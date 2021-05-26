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
      
      def economyTransaction(type, points, userid)
         #Adds the art points to the economy
         newTransaction = Economy.new(params[:economy])
         newTransaction.econtype = "Content"
         newTransaction.content_type = "Mainfolder"
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
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
                     if(logged_in.pouch.privilege != "Admin")
                        #Removes the content and decrements the owner's pouch
                        cleanup = Fieldcost.find_by_name("Mainfoldercleanup")
                        mainfolderFound.user.pouch.amount -= cleanup.amount
                        @pouch = mainfolderFound.user.pouch
                        @pouch.save
                        economyTransaction("Tax", cleanup.amount, mainfolderFound.user_id)
                     end
                     @mainfolder.destroy
                     flash[:success] = "#{mainfolderFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to mainfolders_path
                     else
                        redirect_to user_gallery_path(mainfolderFound.gallery.user, mainfolder.gallery)
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
            if(type == "index") #Guests
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
                           mainfoldercost = Fieldcost.find_by_name("Mainfolder")
                           if(logged_in.pouch.amount - mainfoldercost.amount >= 0)
                              if(@mainfolder.save)
                                 logged_in.pouch.amount -= mainfoldercost.amount
                                 economyTransaction("Sink", mainfoldercost.amount, mainfolder.user_id)
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 updateGallery(@mainfolder.gallery)
                                 flash[:success] = "#{@mainfolder.title} was successfully created."
                                 redirect_to gallery_mainfolder_path(@gallery, @mainfolder)
                              else
                                 render "new"
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
