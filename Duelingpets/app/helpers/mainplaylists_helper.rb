module MainplaylistsHelper

   private
      def getMainplaylistParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Channel")
            value = params[:channel_id]
         elsif(type == "Mainplaylist")
            value = params.require(:mainplaylist).permit(:title, :description)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def updateChannel(channel)
         channel.updated_on = currentTime
         @channel = channel
         @channel.save
      end

      def getSubplaylistMusic(subplaylist)
         allMovies = subplaylist.movies.order("updated_on desc", "reviewed_on desc")
         movies = allMovies.select{|movie| movie.reviewed && checkBookgroupStatus(movie)}
         return movies.first
      end

      def editCommons(type)
         mainplaylistFound = Mainplaylist.find_by_id(getMainplaylistParams("Id"))
         if(mainplaylistFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == mainplaylistFound.user_id) || logged_in.pouch.privilege == "Admin"))
               mainplaylistFound.updated_on = currentTime
               @mainplaylist = mainplaylistFound
               @channel = Channel.find_by_name(mainplaylistFound.channel.name)
               if(type == "update")
                  if(@mainplaylist.update_attributes(getMainplaylistParams("Mainplaylist")))
                     updateChannel(@channel)
                     flash[:success] = "Mainplaylist #{@mainplaylist.title} was successfully updated."
                     redirect_to channel_mainplaylist_path(@mainplaylist.channel, @mainplaylist)
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
         mainplaylistFound = Mainplaylist.find_by_id(getMainplaylistParams("Id"))
         if(mainplaylistFound)
            removeTransactions
            if((current_user && ((mainplaylistFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(mainplaylistFound.channel))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @mainplaylist = mainplaylistFound

               #Come back to this when subsheets is added
               subplaylists = mainplaylistFound.subplaylists
               @subplaylists = Kaminari.paginate_array(subplaylists).page(getMainplaylistParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == mainplaylistFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @mainplaylist.destroy
                     flash[:success] = "#{mainplaylistFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to mainplaylists_path
                     else
                        redirect_to user_channel_path(mainplaylistFound.channel.user, mainplaylistFound.channel)
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
            if(type == "index") #Guests
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allMainplaylists = Mainplaylist.order("updated_on desc, created_on desc")
                  @mainplaylists = Kaminari.paginate_array(allMainplaylists).page(getMainplaylistParams("Page")).per(10)
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
                  channelFound = Channel.find_by_name(getMainplaylistParams("Channel"))
                  if(logged_in && channelFound)
                     if(logged_in.id == channelFound.user_id)
                        newMainplaylist = channelFound.mainplaylists.new
                        if(type == "create")
                           newMainplaylist = channelFound.mainplaylists.new(getMainplaylistParams("Mainplaylist"))
                           newMainplaylist.created_on = currentTime
                           newMainplaylist.updated_on = currentTime
                           newMainplaylist.user_id = logged_in.id
                        end

                        @mainplaylist = newMainplaylist
                        @channel = channelFound

                        if(type == "create")
                           mainplaylistcost = Fieldcost.find_by_name("Mainplaylist")
                           if(logged_in.pouch.amount - mainplaylistcost.amount >= 0)
                              logged_in.pouch.amount -= mainplaylistcost.amount
                              @pouch = logged_in.pouch
                              @pouch.save
                              if(@mainplaylist.save)
                                 updateChannel(@mainplaylist.channel)
                                 flash[:success] = "#{@mainplaylist.title} was successfully created."
                                 redirect_to channel_mainplaylist_path(@channel, @mainplaylist)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create a mainplaylist!"
                              redirect_to root_path
                           end
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
            end
         end
      end
end
