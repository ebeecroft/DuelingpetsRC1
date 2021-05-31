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
      
      def economyTransaction(type, points, userid)
         #Adds the art points to the economy
         newTransaction = Economy.new(params[:economy])
         newTransaction.econtype = "Content"
         newTransaction.content_type = "Mainsheet"
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
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

               #Come back to this when subsheets is added
               subsheets = mainsheetFound.subsheets
               @subsheets = Kaminari.paginate_array(subsheets).page(getMainsheetParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == mainsheetFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     if(logged_in.pouch.privilege != "Admin")
                        #Removes the content and decrements the owner's pouch
                        cleanup = Fieldcost.find_by_name("Mainsheetcleanup")
                        mainsheetFound.user.pouch.amount -= cleanup.amount
                        @pouch = mainsheetFound.user.pouch
                        @pouch.save
                        economyTransaction("Tax", cleanup.amount, mainsheetFound.user_id)
                     end
                     @mainsheet.destroy
                     flash[:success] = "#{mainsheetFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to mainsheets_path
                     else
                        redirect_to user_jukebox_path(mainsheetFound.jukebox.user, mainsheetFound.jukebox)
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
                           mainsheetcost = Fieldcost.find_by_name("Mainsheet")
                           if(logged_in.pouch.amount - mainsheetcost.amount >= 0)
                              if(@mainsheet.save)
                                 logged_in.pouch.amount -= mainsheetcost.amount
                                 economyTransaction("Sink", mainsheetcost.amount, mainsheet.user_id)
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 updateJukebox(@mainsheet.jukebox)
                                 flash[:success] = "#{@mainsheet.title} was successfully created."
                                 redirect_to jukebox_mainsheet_path(@jukebox, @mainsheet)
                              else
                                 render "new"
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
