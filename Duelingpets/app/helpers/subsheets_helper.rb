module SubsheetsHelper

   private
      def getSubsheetParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Mainsheet")
            value = params[:mainsheet_id]
         elsif(type == "Subsheet")
            value = params.require(:subsheet).permit(:title, :description, :collab_mode, :fave_folder, :privatesubsheet)
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
            newTransaction.econattr = "Purchase"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Subsheet"
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

      def updateJukebox(mainsheet)
         mainsheet.updated_on = currentTime
         @mainsheet = mainsheet
         @mainsheet.save
         jukebox = Jukebox.find_by_id(@mainsheet.jukebox_id)
         jukebox.updated_on = currentTime
         @jukebox = jukebox
         @jukebox.save
      end

      def editCommons(type)
         subsheetFound = Subsheet.find_by_id(getSubsheetParams("Id"))
         if(subsheetFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == subsheetFound.user_id) || logged_in.pouch.privilege == "Admin"))
               subsheetFound.updated_on = currentTime
               @subsheet = subsheetFound
               @mainsheet = Mainsheet.find_by_id(subsheetFound.mainsheet.id)
               if(type == "update")
                  if(@subsheet.update_attributes(getSubsheetParams("Subsheet")))
                     updateJukebox(@mainsheet)
                     flash[:success] = "Subsheet #{@subsheet.title} was successfully updated."
                     redirect_to mainsheet_subsheet_path(@subsheet.mainsheet, @subsheet)
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
         subsheetFound = Subsheet.find_by_id(getSubsheetParams("Id"))
         if(subsheetFound)
            removeTransactions
            if((current_user && ((subsheetFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (!subsheetFound.privatesubsheet? && checkBookgroupStatus(subsheetFound.mainsheet.jukebox)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @subsheet = subsheetFound
               sounds = subsheetFound.sounds
               @sounds = Kaminari.paginate_array(sounds).page(getSubsheetParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == subsheetFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Subsheetcleanup")
                     if(subsheetFound.user.pouch.amount - cleanup.amount >= 0)
                        #Removes the content and decrements the owner's pouch
                        subsheetFound.user.pouch.amount -= cleanup.amount
                        @pouch = subsheetFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup.amount, subsheetFound.user.id, "Points")
                        flash[:success] = "#{@subsheet.title} was successfully removed."
                        @subsheet.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to subsheets_path
                        else
                           redirect_to jukebox_mainsheet_path(subsheetFound.mainsheet.jukebox, subsheet.mainsheet)
                        end
                     else
                        flash[:error] = "#{@subsheet.user.vname}'s has insufficient points to remove the subsheet!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to subsheets_path
                        else
                           redirect_to jukebox_mainsheet_path(subsheetFound.mainsheet.jukebox, subsheet.mainsheet)
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
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allSubsheets = Subsheet.order("updated_on desc, created_on desc")
                  @subsheets = Kaminari.paginate_array(allSubsheets).page(getSubsheetParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               jukeboxMode = Maintenancemode.find_by_id(11)
               if(allMode.maintenance_on || jukeboxMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/jukeboxes/maintenance"
                  end
               else
                  logged_in = current_user
                  mainsheetFound = Mainsheet.find_by_id(getSubsheetParams("Mainsheet"))
                  if(logged_in && mainsheetFound)
                     if(logged_in.id == mainsheetFound.user_id)
                        newSubsheet = mainsheetFound.subsheets.new
                        if(type == "create")
                           newSubsheet = mainsheetFound.subsheets.new(getSubsheetParams("Subsheet"))
                           newSubsheet.created_on = currentTime
                           newSubsheet.updated_on = currentTime
                           newSubsheet.user_id = logged_in.id
                        end

                        @subsheet = newSubsheet
                        @mainsheet = mainsheetFound

                        if(type == "create")
                           price = Fieldcost.find_by_name("Subsheet")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(@subsheet.save)
                                 logged_in.pouch.amount -= price.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 hoard = Dragonhoard.find_by_id(1)
                                 hoard.profit += tax
                                 @hoard = hoard
                                 @hoard.save
                                 economyTransaction("Sink", price.amount - tax, newSubsheet.user.id, "Points")
                                 economyTransaction("Tax", tax, newSubsheet.user.id, "Points")
                                 updateJukebox(@subsheet.mainsheet)
                                 flash[:success] = "#{@subsheet.title} was successfully created."
                                 redirect_to mainsheet_subsheet_path(@mainsheet, @subsheet)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create a subsheet!"
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
                  jukeboxMode = Maintenancemode.find_by_id(11)
                  if(allMode.maintenance_on || jukeboxMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/jukeboxes/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               jukeboxMode = Maintenancemode.find_by_id(11)
               if(allMode.maintenance_on || jukeboxMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/jukeboxes/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            end
         end
      end
end
