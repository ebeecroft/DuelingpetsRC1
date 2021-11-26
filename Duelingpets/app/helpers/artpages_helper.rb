module ArtpagesHelper

   private
      def getArtpageParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Artpage")
            value = params.require(:artpage).permit(:name, :message, :art, :remote_art_url, :art_cache)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            removeTransactions #Repurpose this to create pages!
            staff = (logged_in && logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Keymaster")
            if(type == "index")
               #Staff only
               if(staff)
                  allPages = Artpage.order("created_on desc")
                  @artpages = Kaminari.paginate_array(allArts).page(getArtpageParams("Page")).per(10)
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               #Staff only
               if(staff)
                  #Creates the specified page
                  newPage = Artpage.new
                  if(type == "create")
                     newPage = Artpage.new(getArtpageParams("Artpage"))
                     newPage.created_on = currentTime
                  end
                  @artpage = newPage
                  if(type == "create")
                     if(@artpage.save)
                        flash[:success] = "The page #{@artpage.name} has been successfully created."
                        redirect_to artpages_path
                     else
                        render "new"
                     end
                  end
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               #Staff only
               pageFound = Artpage.find_by_id(getArtpageParams("Id"))
               if(staff && pageFound)
                  @artpage = pageFound
                  if(type == "update")
                     if(@artpage.update_attributes(getArtpageParams("Artpage")))
                        flash[:success] = "The page #{@artpage.name} was successfully updated."
                        redirect_to artpages_path
                     else
                        render "edit"
                     end
                  elsif(type == "destroy")
                     flash[:success] = "The page #{@artpage.name} was successfully removed."
                     @artpage.destroy
                     redirect_to artpages_path
                  end
               else
                  if(!pageFound)
                     flash[:error] = "Page doesn't exist!"
                  else
                     flash[:error] = "This page is restricted to Staff only!"
                  end
                  redirect_to root_path
               end
            end
         end
      end
end
