module ShoutsHelper

   private
      def getShoutParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ShoutId")
            value = params[:shout_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Shout")
            value = params.require(:shout).permit(:message, :shoutbox_id)
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
            newTransaction.econattr = "Communication"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Shout"
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

      def editCommons(type)
         shoutFound = Shout.find_by_id(getShoutParams("Id"))
         if(shoutFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == shoutFound.user_id) || logged_in.pouch.privilege == "Admin"))
               shoutFound.updated_on = currentTime
               shoutFound.reviewed = false
               @shoutbox = Shoutbox.find_by_id(shoutFound.shoutbox)
               @shout = shoutFound
               if(type == "update")
                  if(@shout.update_attributes(getShoutParams("Shout")))
                     flash[:success] = "Shout was successfully updated."
                     redirect_to user_path(@shout.shoutbox.user)
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

      def destroyCommons(logged_in)
         shoutFound = Shout.find_by_id(params[:id])
         if(shoutFound && logged_in)
            if((logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Manager") || ((shoutFound.user_id == logged_in.id) || (shoutFound.shoutbox.user_id == logged_in.id)))
               cleanup = Fieldcost.find_by_name("Shoutcleanup")
               if(shoutFound.user.pouch.amount - cleanup.amount >= 0)
                  #Removes the content and decrements the owner's pouch
                  shoutFound.user.pouch.amount -= cleanup.amount
                  @pouch = shoutFound.user.pouch
                  @pouch.save
                  economyTransaction("Sink", cleanup.amount, shoutFound.user.id, "Points")
                  flash[:success] = "Shout was successfully removed!"
                  @shout = shoutFound
                  @shout.destroy
                  if(logged_in.pouch.privilege == "Admin")
                     redirect_to shouts_path
                  else
                     redirect_to user_path(shoutFound.shoutbox.user)
                  end
               else
                  flash[:error] = "#{shoutFound.user.vname}'s has insufficient points to remove the shout!"
                  if(logged_in.pouch.privilege == "Admin")
                     redirect_to shouts_path
                  else
                     redirect_to user_path(shoutFound.shoutbox.user)
                  end
               end
            else
               redirect_to root_path
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
               if(logged_in && (logged_in.pouch.privilege == "Admin"))
                  removeTransactions
                  allShouts = Shout.order("id desc")
                  @shouts = Kaminari.paginate_array(allShouts).page(getShoutParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "create")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(allMode.maintenance_on)
                    render "start/maintenance"
                  else
                    render "users/maintenance"
                  end
               else
                  logged_in = current_user
                  boxFound = Shoutbox.find_by_id(params[:shoutbox_id])
                  if((logged_in && boxFound) && (logged_in.id != boxFound.user_id))
                     newShout = boxFound.shouts.new(getShoutParams("Shout"))
                     newShout.user_id = logged_in.id
                     newShout.created_on = currentTime
                     @shout = newShout
                     @shout.save
                     url = "http://www.duelingpets.net/shouts/review"
                     CommunityMailer.shouts(@shout, "Review", url).deliver_now
                     flash[:success] = "#{@shout.user.vname} shout was successfully created!"
                     redirect_to user_path(boxFound.user)
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
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
                     editCommons(type)
                  end
               end
            elsif(type == "destroy")
               logged_in = current_user
               if(logged_in && (logged_in.pouch.privilege == "Admin"))
                  destroyCommons(logged_in)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "start/maintenance"
                     else
                        render "users/maintenance"
                     end
                  else
                     destroyCommons(logged_in)
                  end
               end
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  shoutbox = Shoutbox.find_by_user_id(logged_in.id)
                  allShouts = Shout.order("reviewed_on desc, created_on desc")
                  shoutsToReview = ""
                  if((logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Manager"))
                     shoutsToReview = allShouts.select{|shout| !shout.reviewed}
                  else
                     shoutsToReview = allShouts.select{|shout| !shout.reviewed && shout.shoutbox_id == shoutbox.id}
                  end
                  @shouts = Kaminari.paginate_array(shoutsToReview).page(getShoutParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  shoutFound = Shout.find_by_id(getShoutParams("ShoutId"))
                  if(shoutFound)
                     if((logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Manager") || (logged_in.id == shoutFound.shoutbox.user_id))
                        if(type == "approve")
                           #Determines if the player can pay for it
                           price = Fieldcost.find_by_name("Shout")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(shoutFound.user.pouch.amount - price.amount >= 0)
                              shoutFound.user.pouch.amount -= price.amount
                              @pouch = shoutFound.user.pouch
                              @pouch.save
                              hoard = Dragonhoard.find_by_id(1)
                              hoard.profit += tax
                              @hoard = hoard
                              @hoard.save
                              shoutFound.reviewed = true
                              shoutFound.reviewed_on = currentTime
                              @shout = shoutFound
                              @shout.save
                              economyTransaction("Sink", price - tax, shoutFound.user.id, "Points")
                              economyTransaction("Tax", tax, shoutFound.user.id, "Points")
                              url = "None"
                              CommunityMailer.shouts(@shout, "Approved", url).deliver_now
                              flash[:success] = "#{@shout.user.vname}'s shout message #{@shout.message} was approved!"
                              redirect_to shouts_review_path
                           else
                              flash[:error] = "Insufficient funds to create a shout!"
                              redirect_to shouts_review_path
                           end
                        else
                           @shout = shoutFound
                           url = "None"
                           CommunityMailer.shouts(@shout, "Denied", url).deliver_now
                           flash[:success] = "#{shoutFound.user.vname}'s shout message #{shoutFound.message} was denied!"
                           redirect_to shouts_review_path
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
