module SuspendedtimelimitsHelper

   private
      def getTimelimitParams(type)
         value = ""
         if(type == "Timelimit")
            value = params.require(:suspendedtimelimit).permit(:reason, :user_id, :timelimit, :pointfines, :emeraldfines)
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
            logged_in = current_user
            if(logged_in && logged_in.pouch.privilege == "Admin")
               if(type == "index")
                  removeTransactions
                  allUsers = Suspendedtimelimit.order("id asc")
                  @suspendedtimelimits = Kaminari.paginate_array(allUsers).page(getTimelimitParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  newTimelimit = Suspendedtimelimit.new
                  if(type == "create")
                     newTimelimit = Suspendedtimelimit.new(getTimelimitParams("Timelimit"))
                     newTimelimit.created_on = currentTime
                     newTimelimit.from_user_id = logged_in.id
                  end

                  #Finds all normal users
                  allUsers = User.order("joined_on desc")
                  users = allUsers.select{|user| user.pouch.privilege != "Admin" && user.pouch.privilege != "Glitchy" && user.pouch.privilege != "Bot" && user.pouch.privilege != "Trial"}
                  @users = users
                  @suspendedtimelimit = newTimelimit
                  if(type == "create")
                     if(@suspendedtimelimit.save)
                        pouchFound = Pouch.find_by_user_id(@suspendedtimelimit.user_id)
                        pouchFound.banned = true
                        pouchFound.amount -= @suspendedtimelimit.fines
                        @pouch = pouchFound
                        @pouch.save
                        flash[:success] = "A new timelimit was successfully created."
                        redirect_to suspendedtimelimits_url
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update" || type == "destroy")
                  timelimitFound = Suspendedtimelimit.find_by_id(params[:id])
                  if(timelimitFound)
                     #Finds all normal users
                     allUsers = User.order("joined_on desc")
                     users = allUsers.select{|user| user.pouch.privilege != "Admin" && user.pouch.privilege != "Glitchy" && user.pouch.privilege != "Bot" && user.pouch.privilege != "Trial"}
                     @users = users
                     @suspendedtimelimit = timelimitFound
                     if(type == "update")
                        #This area will need to be fixed
                        if(@suspendedtimelimit.update_attributes(params[:suspendedtimelimit]))
                           flash[:success] = "Timelimit was successfully updated."
                           redirect_to suspendedtimelimits_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        flash[:success] = "Timelimit was successfully removed."
                        pouchFound = Pouch.find_by_user_id(@suspendedtimelimit.user_id)
                        pouchFound.banned = false
                        @pouch = pouchFound
                        @pouch.save
                        @suspendedtimelimit.destroy
                        redirect_to suspendedtimelimits_path
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
