module PmboxesHelper

   private
      def getBoxParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
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
            if(type == "index")
               logged_in = current_user
               if(logged_in && (logged_in.pouch.privilege == "Admin"))
                  removeTransactions
                  allBoxes = Pmbox.order("id desc")
                  @pmboxes = Kaminari.paginate_array(allBoxes).page(getBoxParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "inbox" || type == "outbox")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/users/maintenance"
                  end
               else
                  logged_in = current_user
                  if(logged_in)
                     #Determines wether the user is looking at the inbox or outbox
                     allPms = Pm.order("created_on desc")
                     pmbox = allPms.select{|pm| pm.pmbox.user_id == logged_in.id || pm.pmreplies.count > 0}
                     if(type == "outbox")
                        pmbox = allPms.select{|pm| pm.user_id == logged_in.id}
                     end
                     @user = User.find_by_id(logged_in.id)
                     @pms = Kaminari.paginate_array(pmbox).page(params[:page]).per(10)
                  else
                     redirect_to root_path
                  end
               end
            end
         end
      end
end
