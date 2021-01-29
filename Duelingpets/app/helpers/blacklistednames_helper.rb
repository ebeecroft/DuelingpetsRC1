module BlacklistednamesHelper

   private
      def getBlacklistParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Blacklist")
            value = params.require(:blacklistedname).permit(:name)
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
                  allNames = Blacklistedname.order("created_on desc")
                  @blacklistednames = Kaminari.paginate_array(allNames).page(getBlacklistParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  newName = Blacklistedname.new
                  if(type == "create")
                     newName = Blacklistedname.new(getBlacklistParams("Blacklist"))
                     newName.created_on = currentTime
                  end
                  @blacklistedname = newName
                  if(type == "create")
                     if(@blacklistedname.save)
                        flash[:success] = "The name #{@blacklistedname.name} has been added to the blacklist!"
                        redirect_to blacklistednames_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update" || type == "destroy")
                  nameFound = Blacklistedname.find_by_id(getBlacklistParams("Id"))
                  if(nameFound)
                     @blacklistedname = nameFound
                     if(type == "update")
                        if(@blacklistedname.update_attributes(getBlacklistParams("Blacklist")))
                           flash[:success] = "The name #{@blacklistedname.name} was successfully updated."
                           redirect_to blacklistednames_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        flash[:success] = "Blacklisted name #{@blacklistedname.name} was successfully removed."
                        @blacklistedname.destroy
                        redirect_to blacklistednames_path
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
