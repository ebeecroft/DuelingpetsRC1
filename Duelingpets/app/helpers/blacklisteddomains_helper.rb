module BlacklisteddomainsHelper

   private
      def getDomainParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Blacklist")
            value = params.require(:blacklisteddomain).permit(:name, :domain_only)
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
                  allDomains = Blacklisteddomain.order("created_on desc")
                  @blacklisteddomains = Kaminari.paginate_array(allDomains).page(getDomainParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  newDomain = Blacklisteddomain.new
                  if(type == "create")
                     newDomain = Blacklisteddomain.new(getDomainParams("Blacklist"))
                     newDomain.created_on = currentTime
                  end
                  @blacklisteddomain = newDomain
                  if(type == "create")
                     if(@blacklisteddomain.save)
                        flash[:success] = "The domain #{@blacklisteddomain.name} has been added to the blacklist!"
                        redirect_to blacklisteddomains_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update" || type == "destroy")
                  domainFound = Blacklisteddomain.find_by_id(getDomainParams("Id"))
                  if(domainFound)
                     @blacklisteddomain = domainFound
                     if(type == "update")
                        if(@blacklisteddomain.update_attributes(getDomainParams("Blacklist")))
                           flash[:success] = "The domain #{@blacklisteddomain.name} was successfully updated."
                           redirect_to blacklisteddomains_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        flash[:success] = "Blacklisted domain #{@blacklisteddomain.name} was successfully removed."
                        @blacklisteddomain.destroy
                        redirect_to blacklisteddomains_path
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
