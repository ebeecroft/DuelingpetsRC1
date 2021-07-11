module MoviesHelper

   private
      def getMovieParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "MovieId")
            value = params[:movie_id]
         elsif(type == "Subplaylist")
            value = params[:subplaylist_id]
         elsif(type == "Movie")
            value = params.require(:movie).permit(:title, :description, :ogv, :remote_ogv_url, :ogv_cache,
            :mp4, :remote_mp4_url, :mp4_cache, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Content"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Movie"
         newTransaction.econtype = type
         newTransaction.amount = points
         #Currency can be either Points, Emeralds or Skildons
         newTransaction.currency = currency
         if(type != "Tax")
            newTransaction.user_id = userid
         else
            newTransaction.dragonhoard_id = 1
         end
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def updateChannel(subplaylist)
         subplaylist.updated_on = currentTime
         @subplaylist = subplaylist
         @subplaylist.save
         mainplaylist = Mainplaylist.find_by_id(@subplaylist.mainplaylist_id)
         mainplaylist.updated_on = currentTime
         @mainplaylist = mainplaylist
         @mainplaylist.save
         channel = Channel.find_by_id(@mainplaylist.channel_id)
         channel.updated_on = currentTime
         @channel = channel
         @channel.save
      end

      def editCommons(type)
         movieFound = Movie.find_by_id(getMovieParams("Id"))
         if(movieFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == movieFound.user_id) || logged_in.pouch.privilege == "Admin"))
               movieFound.updated_on = currentTime
               movieFound.reviewed = false

               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               @movie = movieFound
               @subplaylist = Subplaylist.find_by_id(movieFound.subplaylist.id)
               if(type == "update")
                  if(@movie.update_attributes(getMovieParams("Movie")))
                     updateChannel(@subplaylist)
                     flash[:success] = "Movie #{@movie.title} was successfully updated."
                     redirect_to subplaylist_movie_path(@movie.subplaylist, @movie)
                  else
                     render "edit"
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def showCommons(type)
         movieFound = Movie.find_by_id(getMovieParams("Id"))
         if(movieFound)
            removeTransactions
            if((current_user && ((movieFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (checkBookgroupStatus(movieFound)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @movie = movieFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == movieFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Moviecleanup")
                     if(movieFound.user.pouch.amount - cleanup.amount >= 0)
                        #Removes the content and decrements the owner's pouch
                        movieFound.user.pouch.amount -= cleanup.amount
                        @pouch = movieFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup.amount, movieFound.user.id, "Points")
                        flash[:success] = "#{@movie.title} was successfully removed."
                        @movie.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to movies_path
                        else
                           redirect_to mainplaylist_subplaylist_path(movieFound.subplaylist.mainplaylist, movieFound.subplaylist)
                        end
                     else
                        flash[:error] = "#{@movie.user.vname}'s has insufficient points to remove the movie!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to movies_path
                        else
                           redirect_to mainplaylist_subplaylist_path(movieFound.subplaylist.mainplaylist, movieFound.subplaylist)
                        end
                     end
                  else
                     redirect_to root_path
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allMovies = Movie.order("updated_on desc, created_on desc")
                  @movies = Kaminari.paginate_array(allMovies).page(getMovieParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               channelMode = Maintenancemode.find_by_id(13)
               if(allMode.maintenance_on || channelMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/channels/maintenance"
                  end
               else
                  logged_in = current_user
                  subplaylistFound = Subplaylist.find_by_id(getMovieParams("Subplaylist"))
                  if(logged_in && subplaylistFound)
                     if(logged_in.id == subplaylistFound.user_id || (subplaylistFound.collab_mode &&
                        checkBookgroupStatus(subplaylistFound.mainplaylist.channel)))
                        if(!subplaylistFound.fave_folder)
                           newMovie = subplaylistFound.movies.new
                           if(type == "create")
                              newMovie = subplaylistFound.movies.new(getMovieParams("Movie"))
                              newMovie.created_on = currentTime
                              newMovie.updated_on = currentTime
                              newMovie.user_id = logged_in.id
                           end

                           #Determines the type of bookgroup the user belongs to
                           allGroups = Bookgroup.order("created_on desc")
                           allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                           @group = allowedGroups
                           @movie = newMovie
                           @subplaylist = subplaylistFound

                           if(type == "create")
                              if(@movie.save)
                                 movietag = Movietag.new(params[:movietag])
                                 movietag.movie_id = @movie.id
                                 movietag.tag1_id = 1
                                 @movietag = movietag
                                 @movietag.save
                                 updateChannel(@movie.subplaylist)
                                 url = "http://www.duelingpets.net/movies/review"
                                 ContentMailer.content_review(@movie, "Movie", url).deliver_now
                                 flash[:success] = "#{@movie.title} was successfully created."
                                 redirect_to subplaylist_movie_path(@subplaylist, @movie)
                              else
                                 render "new"
                              end
                           end
                        else
                           flash[:error] = "Favorite folders don't support video!"
                           redirect_to root_path
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  channelMode = Maintenancemode.find_by_id(13)
                  if(allMode.maintenance_on || channelMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/channels/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               channelMode = Maintenancemode.find_by_id(13)
               if(allMode.maintenance_on || channelMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/channels/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allMovies = Movie.order("reviewed_on desc, created_on desc")
                  if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                     moviesToReview = allMovies.select{|movie| !movie.reviewed}
                     @movies = Kaminari.paginate_array(moviesToReview).page(getMovieParams("Page")).per(10)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  movieFound = Movie.find_by_id(getMovieParams("MovieId"))
                  if(movieFound)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           movieFound.reviewed = true
                           movieFound.reviewed_on = currentTime
                           updateChannel(movieFound.subplaylist)

                           #Adds the points to the user's pouch
                           moviepoints = Fieldcost.find_by_name("Movie")
                           pointsForMovie = moviepoints.amount
                           @movie = movieFound
                           @movie.save
                           pouch = Pouch.find_by_user_id(@movie.user_id)
                           pouch.amount += pointsForMovie
                           @pouch = pouch
                           @pouch.save
                           economyTransaction("Source", pointsForMovie, movieFound.user.id, "Points")
                           ContentMailer.content_approved(@movie, "Movie", pointsForMovie).deliver_now
                           flash[:success] = "#{@movie.user.vname}'s movie #{@movie.title} was approved."
                           redirect_to movies_review_path
                        else
                           @movie = movieFound
                           ContentMailer.content_denied(@movie, "Movie").deliver_now
                           flash[:success] = "#{@movie.user.vname}'s movie #{@movie.title} was denied."
                           redirect_to movies_review_path
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
