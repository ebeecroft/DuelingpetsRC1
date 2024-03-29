module SubfoldersHelper

   private
      def getSubfolderParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Mainfolder")
            value = params[:mainfolder_id]
         elsif(type == "Subfolder")
            value = params.require(:subfolder).permit(:title, :description, :collab_mode, :fave_folder, :privatesubfolder)
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
         newTransaction.content_type = "Subfolder"
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

      def updateGallery(mainfolder)
         mainfolder.updated_on = currentTime
         @mainfolder = mainfolder
         @mainfolder.save
         gallery = Gallery.find_by_id(@mainfolder.gallery_id)
         gallery.updated_on = currentTime
         @gallery = gallery
         @gallery.save
      end

      def editCommons(type)
         subfolderFound = Subfolder.find_by_id(getSubfolderParams("Id"))
         if(subfolderFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == subfolderFound.user_id) || logged_in.pouch.privilege == "Admin"))
               subfolderFound.updated_on = currentTime
               @subfolder = subfolderFound
               @mainfolder = Mainfolder.find_by_id(subfolderFound.mainfolder.id)
               if(type == "update")
                  if(@subfolder.update_attributes(getSubfolderParams("Subfolder")))
                     updateGallery(@mainfolder)
                     flash[:success] = "Subfolder #{@subfolder.title} was successfully updated."
                     redirect_to mainfolder_subfolder_path(@subfolder.mainfolder, @subfolder)
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
         subfolderFound = Subfolder.find_by_id(getSubfolderParams("Id"))
         if(subfolderFound)
            removeTransactions
            if((current_user && ((subfolderFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (!subfolderFound.privatesubfolder? && checkBookgroupStatus(subfolderFound.mainfolder.gallery)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @subfolder = subfolderFound
               arts = subfolderFound.arts
               @arts = Kaminari.paginate_array(arts).page(getSubfolderParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == subfolderFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Subfoldercleanup")
                     if(subfolderFound.user.pouch.amount - cleanup.amount >= 0)
                        if(subfolderFound.user.gameinfo.startgame)
                           #Removes the content and decrements the owner's pouch
                           subfolderFound.user.pouch.amount -= cleanup.amount
                           @pouch = subfolderFound.user.pouch
                           @pouch.save
                           economyTransaction("Sink", cleanup.amount, subfolderFound.user.id, "Points")
                           flash[:success] = "#{@subfolder.title} was successfully removed."
                           @subfolder.destroy
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to subfolders_path
                           else
                              redirect_to gallery_mainfolder_path(subfolderFound.mainfolder.gallery, subfolder.mainfolder)
                           end
                        else
                           if(logged_in.pouch.privilege == "Admin")
                              flash[:error] = "The artist has not activated the game yet!"
                              redirect_to subfolders_path
                           else
                              flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                              redirect_to edit_gameinfo_path(logged_in.gameinfo)
                           end
                        end
                     else
                        flash[:error] = "#{@subfolder.user.vname}'s has insufficient points to remove the subfolder!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to subfolders_path
                        else
                           redirect_to gallery_mainfolder_path(subfolderFound.mainfolder.gallery, subfolder.mainfolder)
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
                  allSubfolders = Subfolder.order("updated_on desc, created_on desc")
                  @subfolders = Kaminari.paginate_array(allSubfolders).page(getSubfolderParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               galleryMode = Maintenancemode.find_by_id(14)
               if(allMode.maintenance_on || galleryMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/galleries/maintenance"
                  end
               else
                  logged_in = current_user
                  mainfolderFound = Mainfolder.find_by_id(getSubfolderParams("Mainfolder"))
                  if(logged_in && mainfolderFound)
                     if(logged_in.id == mainfolderFound.user_id)
                        newSubfolder = mainfolderFound.subfolders.new
                        if(type == "create")
                           newSubfolder = mainfolderFound.subfolders.new(getSubfolderParams("Subfolder"))
                           newSubfolder.created_on = currentTime
                           newSubfolder.updated_on = currentTime
                           newSubfolder.user_id = logged_in.id
                        end
                        subfolderCount = logged_in.subfolders.count
                        @subfolder = newSubfolder
                        @mainfolder = mainfolderFound

                        if(type == "create")
                           price = Fieldcost.find_by_name("Subfolder")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(logged_in.gameinfo.startgame)
                                 if(@subfolder.save)
                                    logged_in.pouch.amount -= price.amount
                                    @pouch = logged_in.pouch
                                    @pouch.save
                                    hoard = Dragonhoard.find_by_id(1)
                                    hoard.profit += tax
                                    @hoard = hoard
                                    @hoard.save
                                    economyTransaction("Sink", price.amount - tax, subfolderFound.user.id, "Points")
                                    economyTransaction("Tax", tax, subfolderFound.user.id, "Points")
                                    updateGallery(@subfolder.mainfolder)
                                    flash[:success] = "#{@subfolder.title} was successfully created."
                                    redirect_to mainfolder_subfolder_path(@mainfolder, @subfolder)
                                 else
                                    render "new"
                                 end
                              else
                                 flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                                 redirect_to edit_gameinfo_path(logged_in.gameinfo)
                              end
                           else
                              flash[:error] = "Insufficient funds to create a subfolder!"
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
                  galleryMode = Maintenancemode.find_by_id(14)
                  if(allMode.maintenance_on || galleryMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/galleries/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               galleryMode = Maintenancemode.find_by_id(14)
               if(allMode.maintenance_on || galleryMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/galleries/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            end
         end
      end
end
