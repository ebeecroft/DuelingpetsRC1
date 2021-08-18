module MainfoldersHelper

   private
      def getMainfolderParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Gallery")
            value = params[:gallery_id]
         elsif(type == "Mainfolder")
            value = params.require(:mainfolder).permit(:title, :description)
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
         newTransaction.content_type = "Mainfolder"
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

      def updateGallery(gallery)
         gallery.updated_on = currentTime
         @gallery = gallery
         @gallery.save
      end

      def getSubfolderArt(subfolder)
         allArts = subfolder.arts.order("updated_on desc", "reviewed_on desc")
         arts = allArts.select{|art| (art.reviewed && checkBookgroupStatus(art)) || (current_user && current_user.id == art.user_id)}
         return arts.first
      end

      def editCommons(type)
         mainfolderFound = Mainfolder.find_by_id(getMainfolderParams("Id"))
         if(mainsheetFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == mainfolderFound.user_id) || logged_in.pouch.privilege == "Admin"))
               mainfolderFound.updated_on = currentTime
               @mainfolder = mainfolderFound
               @gallery = Gallery.find_by_name(mainfolderFound.gallery.name)
               if(type == "update")
                  if(@mainfolder.update_attributes(getMainfolderParams("Mainfolder")))
                     updateGallery(@gallery)
                     flash[:success] = "Mainfolder #{@mainfolder.title} was successfully updated."
                     redirect_to gallery_mainfolder_path(@mainfolder.gallery, @mainfolder)
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
         mainfolderFound = Mainfolder.find_by_id(getMainfolderParams("Id"))
         if(mainfolderFound)
            removeTransactions
            if((current_user && ((mainfolderFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(mainfolderFound.gallery))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @mainfolder = mainfolderFound

               #Come back to this when subfolders is added
               subfolders = mainfolderFound.subfolders
               @subfolders = Kaminari.paginate_array(subfolders).page(getMainfolderParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == mainfolderFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Mainfoldercleanup")
                     if(mainfolderFound.user.pouch.amount - cleanup.amount >= 0)
                        if(mainfolderFound.user.gameinfo.startgame)
                           #Removes the content and decrements the owner's pouch
                           mainfolderFound.user.pouch.amount -= cleanup.amount
                           @pouch = mainfolderFound.user.pouch
                           @pouch.save
                           economyTransaction("Sink", cleanup.amount, mainfolderFound.user.id, "Points")
                           flash[:success] = "#{@mainfolder.title} was successfully removed."
                           @mainfolder.destroy
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to mainfolders_path
                           else
                              redirect_to user_gallery_path(mainfolderFound.gallery.user, mainfolderFound.gallery)
                           end
                        else
                           if(logged_in.pouch.privilege == "Admin")
                              flash[:error] = "The artist has not activated the game yet!"
                              redirect_to mainfolders_path
                           else
                              flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                              redirect_to edit_gameinfo_path(logged_in.gameinfo)
                           end
                        end
                     else
                        flash[:error] = "#{@mainfolder.user.vname}'s has insufficient points to remove the mainfolder!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to mainfolders_path
                        else
                           redirect_to user_gallery_path(mainfolderFound.gallery.user, mainfolderFound.gallery)
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
                  allMainfolders = Mainfolder.order("updated_on desc, created_on desc")
                  @mainfolders = Kaminari.paginate_array(allMainfolders).page(getMainfolderParams("Page")).per(10)
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
                  galleryFound = Gallery.find_by_name(getMainfolderParams("Gallery"))
                  if(logged_in && galleryFound)
                     if(logged_in.id == galleryFound.user_id)
                        newMainfolder = galleryFound.mainfolders.new
                        if(type == "create")
                           newMainfolder = galleryFound.mainfolders.new(getMainfolderParams("Mainfolder"))
                           newMainfolder.created_on = currentTime
                           newMainfolder.updated_on = currentTime
                           newMainfolder.user_id = logged_in.id
                        end
                        mainfolderCount = logged_in.mainfolders.count
                        @mainfolder = newMainfolder
                        @gallery = galleryFound

                        if(type == "create")
                           price = Fieldcost.find_by_name("Mainfolder")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(logged_in.gameinfo.startgame)
                                 if(@mainfolder.save)
                                    logged_in.pouch.amount -= price.amount
                                    @pouch = logged_in.pouch
                                    @pouch.save
                                    hoard = Dragonhoard.find_by_id(1)
                                    hoard.profit += tax
                                    @hoard = hoard
                                    @hoard.save
                                    economyTransaction("Sink", price.amount - tax, mainfolderFound.user.id, "Points")
                                    economyTransaction("Tax", tax, mainfolderFound.user.id, "Points")
                                    updateGallery(@mainfolder.gallery)
                                    flash[:success] = "#{@mainfolder.title} was successfully created."
                                    redirect_to gallery_mainfolder_path(@gallery, @mainfolder)
                                 else
                                    render "new"
                                 end
                              else
                                 flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                                 redirect_to edit_gameinfo_path(logged_in.gameinfo)
                              end
                           else
                              flash[:error] = "Insufficient funds to create a mainfolder!"
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
