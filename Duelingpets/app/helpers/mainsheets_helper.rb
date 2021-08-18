module MainsheetsHelper

   private
      def getMainsheetParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Jukebox")
            value = params[:jukebox_id]
         elsif(type == "Mainsheet")
            value = params.require(:mainsheet).permit(:title, :description)
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
         newTransaction.content_type = "Mainsheet"
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

      def updateJukebox(jukebox)
         jukebox.updated_on = currentTime
         @jukebox = jukebox
         @jukebox.save
      end

      def getSubsheetMusic(subsheet)
         allSounds = subsheet.sounds.order("updated_on desc", "reviewed_on desc")
         sounds = allSounds.select{|sound| sound.reviewed && checkBookgroupStatus(sound)}
         return sounds.first
      end

      def editCommons(type)
         mainsheetFound = Mainsheet.find_by_id(getMainsheetParams("Id"))
         if(mainsheetFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == mainsheetFound.user_id) || logged_in.pouch.privilege == "Admin"))
               mainsheetFound.updated_on = currentTime
               @mainsheet = mainsheetFound
               @jukebox = Jukebox.find_by_name(mainsheetFound.jukebox.name)
               if(type == "update")
                  if(@mainsheet.update_attributes(getMainsheetParams("Mainsheet")))
                     updateJukebox(@jukebox)
                     flash[:success] = "Mainsheet #{@mainsheet.title} was successfully updated."
                     redirect_to jukebox_mainsheet_path(@mainsheet.jukebox, @mainsheet)
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
         mainsheetFound = Mainsheet.find_by_id(getMainsheetParams("Id"))
         if(mainsheetFound)
            removeTransactions
            if((current_user && ((mainsheetFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(mainsheetFound.jukebox))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @mainsheet = mainsheetFound
               subsheets = mainsheetFound.subsheets
               @subsheets = Kaminari.paginate_array(subsheets).page(getMainsheetParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == mainsheetFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Mainsheetcleanup")
                     if(mainsheetFound.user.pouch.amount - cleanup.amount >= 0)
                        if(mainsheetFound.user.gameinfo.startgame)
                           #Removes the content and decrements the owner's pouch
                           mainsheetFound.user.pouch.amount -= cleanup.amount
                           @pouch = mainsheetFound.user.pouch
                           @pouch.save
                           economyTransaction("Sink", cleanup.amount, mainsheetFound.user.id, "Points")
                           flash[:success] = "#{@mainsheet.title} was successfully removed."
                           @mainsheet.destroy
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to mainsheets_path
                           else
                             redirect_to user_jukebox_path(mainsheetFound.jukebox.user, mainsheetFound.jukebox)
                           end
                        else
                           if(logged_in.pouch.privilege == "Admin")
                              flash[:error] = "The composer has not activated the game yet!"
                              redirect_to mainsheets_path
                           else
                              flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                              redirect_to edit_gameinfo_path(logged_in.gameinfo)
                           end
                        end
                     else
                        flash[:error] = "#{@mainsheet.user.vname}'s has insufficient points to remove the mainsheet!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to mainsheets_path
                        else
                           redirect_to user_jukebox_path(mainsheetFound.jukebox.user, mainsheetFound.jukebox)
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
                  allMainsheets = Mainsheet.order("updated_on desc, created_on desc")
                  @mainsheets = Kaminari.paginate_array(allMainsheets).page(getMainsheetParams("Page")).per(10)
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
                  jukeboxFound = Jukebox.find_by_name(getMainsheetParams("Jukebox"))
                  if(logged_in && jukeboxFound)
                     if(logged_in.id == jukeboxFound.user_id)
                        newMainsheet = jukeboxFound.mainsheets.new
                        if(type == "create")
                           newMainsheet = jukeboxFound.mainsheets.new(getMainsheetParams("Mainsheet"))
                           newMainsheet.created_on = currentTime
                           newMainsheet.updated_on = currentTime
                           newMainsheet.user_id = logged_in.id
                        end

                        @mainsheet = newMainsheet
                        @jukebox = jukeboxFound

                        if(type == "create")
                           price = Fieldcost.find_by_name("Mainsheet")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(logged_in.gameinfo.startgame)
                                 if(@mainsheet.save)
                                    logged_in.pouch.amount -= price.amount
                                    @pouch = logged_in.pouch
                                    @pouch.save
                                    hoard = Dragonhoard.find_by_id(1)
                                    hoard.profit += tax
                                    @hoard = hoard
                                    @hoard.save
                                    economyTransaction("Sink", price.amount - tax, mainsheetFound.user.id, "Points")
                                    economyTransaction("Tax", tax, mainsheetFound.user.id, "Points")
                                    updateJukebox(@mainsheet.jukebox)
                                    flash[:success] = "#{@mainsheet.title} was successfully created."
                                    redirect_to jukebox_mainsheet_path(@jukebox, @mainsheet)
                                 else
                                    render "new"
                                 end
                              else
                                 flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                                 redirect_to edit_gameinfo_path(logged_in.gameinfo)
                              end
                           else
                              flash[:error] = "Insufficient funds to create a mainsheet!"
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
