module MovietagsHelper

   private
      def getMovietagParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "MovietagId")
            value = params[:movietag_id]
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getTagname(tagid)
         tag = Tag.find_by_id(tagid)
         return tag.name
      end
      
      def tagCommons(type)
         logged_in = current_user
         movietagFound = Movietag.find_by_id(getMovietagParams("MovietagId"))
         if(movietagFound && logged_in)
            if(type == "addtag")
               tagFound = Tag.find_by_name(params[:movietag][:name])
               slotFound = params[:movietag][:tagslot]
               if(tagFound && !slotFound.nil? && logged_in.id == movietagFound.movie.user_id)
                  errorFlag = false
                  #Determines if the tag is already in the movietag list
                  tagset1 = (((movietagFound.tag1_id != tagFound.id && movietagFound.tag2_id != tagFound.id) && (movietagFound.tag3_id != tagFound.id && movietagFound.tag4_id != tagFound.id)) && ((movietagFound.tag5_id != tagFound.id && movietagFound.tag6_id != tagFound.id) && (movietagFound.tag7_id != tagFound.id && movietagFound.tag8_id != tagFound.id)))
                  tagset2 = (((movietagFound.tag9_id != tagFound.id && movietagFound.tag10_id != tagFound.id) && (movietagFound.tag11_id != tagFound.id && movietagFound.tag12_id != tagFound.id)) && ((movietagFound.tag13_id != tagFound.id && movietagFound.tag14_id != tagFound.id) && (movietagFound.tag15_id != tagFound.id && movietagFound.tag16_id != tagFound.id)))
                  tagset3 = ((movietagFound.tag17_id != tagFound.id && movietagFound.tag18_id != tagFound.id) && (movietagFound.tag19_id != tagFound.id && movietagFound.tag20_id != tagFound.id))
                  
                  #Checks if the tag is found
                  if(tagset1 && tagset2 && tagset3)
                     if(slotFound.to_i == 1)
                        movietagFound.tag1_id = tagFound.id
                     elsif(slotFound.to_i == 2)
                        movietagFound.tag2_id = tagFound.id
                     elsif(slotFound.to_i == 3)
                        movietagFound.tag3_id = tagFound.id
                     elsif(slotFound.to_i == 4)
                        movietagFound.tag4_id = tagFound.id
                     elsif(slotFound.to_i == 5)
                        movietagFound.tag5_id = tagFound.id
                     elsif(slotFound.to_i == 6)
                        movietagFound.tag6_id = tagFound.id
                     elsif(slotFound.to_i == 7)
                        movietagFound.tag7_id = tagFound.id
                     elsif(slotFound.to_i == 8)
                        movietagFound.tag8_id = tagFound.id
                     elsif(slotFound.to_i == 9)
                        movietagFound.tag9_id = tagFound.id
                     elsif(slotFound.to_i == 10)
                        movietagFound.tag10_id = tagFound.id
                     elsif(slotFound.to_i == 11)
                        movietagFound.tag11_id = tagFound.id
                     elsif(slotFound.to_i == 12)
                        movietagFound.tag12_id = tagFound.id
                     elsif(slotFound.to_i == 13)
                        movietagFound.tag13_id = tagFound.id
                     elsif(slotFound.to_i == 14)
                        movietagFound.tag14_id = tagFound.id
                     elsif(slotFound.to_i == 15)
                        movietagFound.tag15_id = tagFound.id
                     elsif(slotFound.to_i == 16)
                        movietagFound.tag16_id = tagFound.id
                     elsif(slotFound.to_i == 17)
                        movietagFound.tag17_id = tagFound.id
                     elsif(slotFound.to_i == 18)
                        movietagFound.tag18_id = tagFound.id
                     elsif(slotFound.to_i == 19)
                        movietagFound.tag19_id = tagFound.id
                     elsif(slotFound.to_i == 20)
                        movietagFound.tag20_id = tagFound.id
                     else
                        errorFlag = true
                     end
                     if(!errorFlag)
                        @movietag = movietagFound
                        @movietag.save
                        flash[:success] = "Tag #{tagFound.name} was added to the list!"
                        redirect_to subplaylist_movie_path(@movietag.movie.subplaylist, @movietag.movie)
                     else
                        flash[:error] = "Invalid slot detected!"
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "Tag #{tagFound.name} already exists in this list!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "removetag")
               errorFlag = false
               tagFound = Tag.find_by_id(params[:tagid])
               if(tagFound)
                  if(logged_in.pouch.privilege == "Admin" || logged_in.id == movietagFound.movie.user_id)
                     tag = tagFound.id
                     if(movietagFound.tag1_id == tag)
                        movietagFound.tag1_id = nil
                     elsif(movietagFound.tag2_id == tag)
                        movietagFound.tag2_id = nil
                     elsif(movietagFound.tag3_id == tag)
                        movietagFound.tag3_id = nil
                     elsif(movietagFound.tag4_id == tag)
                        movietagFound.tag4_id = nil
                     elsif(movietagFound.tag5_id == tag)
                        movietagFound.tag5_id = nil
                     elsif(movietagFound.tag6_id == tag)
                        movietagFound.tag6_id = nil
                     elsif(movietagFound.tag7_id == tag)
                        movietagFound.tag7_id = nil
                     elsif(movietagFound.tag8_id == tag)
                        movietagFound.tag8_id = nil
                     elsif(movietagFound.tag9_id == tag)
                        movietagFound.tag9_id = nil
                     elsif(movietagFound.tag10_id == tag)
                        movietagFound.tag10_id = nil
                     elsif(movietagFound.tag11_id == tag)
                        movietagFound.tag11_id = nil
                     elsif(movietagFound.tag12_id == tag)
                        movietagFound.tag12_id = nil
                     elsif(movietagFound.tag13_id == tag)
                        movietagFound.tag13_id = nil
                     elsif(movietagFound.tag14_id == tag)
                        movietagFound.tag14_id = nil
                     elsif(movietagFound.tag15_id == tag)
                        movietagFound.tag15_id = nil
                     elsif(movietagFound.tag16_id == tag)
                        movietagFound.tag16_id = nil
                     elsif(movietagFound.tag17_id == tag)
                        movietagFound.tag17_id = nil
                     elsif(movietagFound.tag18_id == tag)
                        movietagFound.tag18_id = nil
                     elsif(movietagFound.tag19_id == tag)
                        movietagFound.tag19_id = nil
                     elsif(movietagFound.tag20_id == tag)
                        movietagFound.tag20_id = nil
                     else
                        #This case should never happen!
                        errorFlag = true
                     end
                     if(!errorFlag)
                        if(movietagFound.tag1_id.nil? && movietagFound.tag2_id.nil? && movietagFound.tag3_id.nil? && movietagFound.tag4_id.nil? && movietagFound.tag5_id.nil? && movietagFound.tag6_id.nil? && movietagFound.tag7_id.nil? && movietagFound.tag8_id.nil? && movietagFound.tag9_id.nil? && movietagFound.tag10_id.nil? && movietagFound.tag11_id.nil? && movietagFound.tag12_id.nil? && movietagFound.tag13_id.nil? && movietagFound.tag14_id.nil? && movietagFound.tag15_id.nil? && movietagFound.tag16_id.nil? && movietagFound.tag17_id.nil? && movietagFound.tag18_id.nil? && movietagFound.tag19_id.nil? && movietagFound.tag20_id.nil?)
                           movietagFound.tag1_id = 1
                        end
                        @movietag = movietagFound
                        @movietag.save
                        flash[:success] = "Tag #{getTagname(tag)} was successfully removed!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to movietags_path
                        else
                           redirect_to subplaylist_movie_path(@movietag.movie.subplaylist, @movietag.movie)
                        end
                     else
                        flash[:error] = "This tag does not exist!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  flash[:error] = "Tagid is empty!"
                  redirect_to root_path
               end
            end
         else
            redirect_to root_path
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
                  allMovietags = Movietag.all
                  @movietags = Kaminari.paginate_array(allMovietags).page(getMovietagParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "addtag" || type == "removetag")
               if(current_user && current_user.pouch.privilege == "Admin")
                  tagCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     tagCommons(type)
                  end
               end
            end
         end
      end
end
