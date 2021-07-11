module PmsHelper

   private
      def getPmParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "PmId")
            value = params[:pm_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Pm")
            value = params.require(:pm).permit(:title, :message, :image, :remote_image_url, :image_cache, :ogg, :remote_ogg_url, :ogg_cache,
            :mp3, :remote_mp3_url, :mp3_cache, :ogv, :remote_ogv_url, :ogv_cache, :mp4, :remote_mp4_url, :mp4_cache)
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
         newTransaction.content_type = "PM"
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

      def unreadPMs(pm)
         title = ""
         if(pm.user1_unread || pm.user2_unread)
            title = (pm.title + "[*]")
         else
           title = pm.title
         end
         return title
      end

      def editCommons(type)
         pmFound = Pm.find_by_id(getPmParams("Id"))
         if(pmFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == pmFound.user_id) || logged_in.pouch.privilege == "Admin"))
               pmFound.updated_on = currentTime
               @pm = pmFound
               @pmbox = Pmbox.find_by_id(pmFound.pmbox.id)
               if(type == "update")
                  if(@pm.update_attributes(getPmParams("Pm")))
                     flash[:success] = "PM #{@pm.title} was successfully updated."
                     redirect_to pmbox_pm_path(@pm.pmbox, @pm)
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
         pmFound = Pm.find_by_id(getPmParams("Id"))
         if(pmFound)
            if(current_user && (((pmFound.user_id == current_user.id) || (pmFound.pmbox.user_id == current_user.id)) || (current_user.pouch.privilege == "Admin")))
               @pmbox = Pmbox.find_by_id(pmFound.pmbox.id)
               @pm = pmFound
               pmReplies = @pm.pmreplies.order("created_on desc")
               @pmreplies = Kaminari.paginate_array(pmReplies).page(getPmParams("Page")).per(10)
               if(pmFound.user_id == current_user.id)
                  @pm.user1_unread = false
                  @pm.save
               elsif(pmFound.pmbox.user_id == current_user.id)
                  @pm.user2_unread = false
                  @pm.save
               end
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && (((logged_in.id == pmFound.user_id) || (logged_in.id == pmFound.pmbox.user_id)) || (logged_in.pouch.privilege == "Admin")))
                     cleanup = Fieldcost.find_by_name("PMcleanup")
                     if(pmFound.user.pouch.amount - cleanup.amount >= 0)
                        #Removes the content and decrements the owner's pouch
                        pmFound.user.pouch.amount -= cleanup.amount
                        @pouch = pmFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup.amount, pmFound.user.id, "Points")
                        flash[:success] = "#{pmFound.title} was successfully removed."
                        @pm.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to pms_path
                        else
                           redirect_to pmboxes_inbox_path
                        end
                     else
                        flash[:error] = "#{pmFound.user.vname}'s has insufficient points to remove the pm!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to pms_path
                        else
                           redirect_to pmboxes_inbox_path
                        end
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
            if(type == "index")
               if(current_user && current_user.pouch.privilege == "Admin")
                  removeTransactions
                  allPMs = Pm.order("created_on desc")
                  @pms = Kaminari.paginate_array(allPMs).page(getPmParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
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
                  boxFound = Pmbox.find_by_id(params[:pmbox_id])
                  if(logged_in && boxFound)
                     if(logged_in.id != boxFound.id)
                        newPm = boxFound.pms.new
                        if(type == "create")
                           newPm = boxFound.pms.new(getPmParams("Pm"))
                           newPm.created_on = currentTime
                           newPm.updated_on = currentTime
                           newPm.user_id = logged_in.id

                           #Sets the user that receives the pm read status to unread
                           newPm.user2_unread = true
                        end

                        @pm = newPm
                        @pmbox = boxFound

                        if(type == "create")
                           price = Fieldcost.find_by_name("PMcost")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(@pm.save)
                                 logged_in.pouch.amount -= price.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 hoard = Dragonhoard.find_by_id(1)
                                 hoard.profit += tax
                                 @hoard = hoard
                                 @hoard.save
                                 economyTransaction("Sink", price.amount - tax, logged_in.id, "Points")
                                 economyTransaction("Tax", tax, logged_in.id, "Points")
                                 url = "http://www.duelingpets.net/pmboxes/inbox"
                                 CommunityMailer.messaging(@pm, "PM", url).deliver_now
                                 flash[:success] = "#{@pm.title} was successfully created."
                                 redirect_to pmboxes_outbox_path
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create a PM!"
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
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            end
         end
      end
end
