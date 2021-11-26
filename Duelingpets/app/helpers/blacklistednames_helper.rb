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
            removeTransactions
            staff = (logged_in && logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Keymaster")
            if(type == "index")
               #Staff only
               if(staff)
                  allNames = Blacklistedname.order("created_on desc")
                  @blacklistednames = Kaminari.paginate_array(allNames).page(getBlacklistParams("Page")).per(10)
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               #Staff only
               if(staff)
                  #Adds the specified name to the blacklist
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
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               #Staff only
               nameFound = Blacklistedname.find_by_id(getBlacklistParams("Id"))
               if(staff && nameFound)
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
                  if(!nameFound)
                     flash[:error] = "Name doesn't exist!"
                  else
                     flash[:error] = "This page is restricted to Staff only!"
                  end
                  redirect_to root_path
               end
            end
         end
      end
end
