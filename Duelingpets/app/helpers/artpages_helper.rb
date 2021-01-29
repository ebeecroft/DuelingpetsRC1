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
            if(current_user && current_user.pouch.privilege == "Admin")
               if(type == "index")
                  removeTransactions
                  allArts = Artpage.order("created_on desc")
                  @artpages = Kaminari.paginate_array(allArts).page(getArtpageParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  newArt = Artpage.new
                  if(type == "create")
                     newArt = Artpage.new(getArtpageParams("Artpage"))
                     newArt.created_on = currentTime
                  end
                  @artpage = newArt
                  if(type == "create")
                     if(@artpage.save)
                        flash[:success] = "The artpage #{@artpage.name} has been successfully created."
                        redirect_to artpages_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update" || type == "destroy")
                  artFound = Artpage.find_by_id(getArtpageParams("Id"))
                  if(artFound)
                     @artpage = artFound
                     if(type == "update")
                        if(@artpage.update_attributes(getArtpageParams("Artpage")))
                           flash[:success] = "The artpage #{@artpage.name} was successfully updated."
                           redirect_to artpages_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        flash[:success] = "The artpage #{@artpage.name} was successfully removed."
                        @artpage.destroy
                        redirect_to artpages_path
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               end
            else
               redirect_to root_path
            end
         end
      end
end
