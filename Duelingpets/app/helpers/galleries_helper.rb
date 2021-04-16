module GalleriesHelper

   private
      def getGalleryParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "GalleryId")
            value = params[:gallery_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Gallery")
            value = params.require(:gallery).permit(:name, :description, :bookgroup_id, :privategallery,
            :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache, :gviewer_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getArtCounts(mainfolder)
         allArts = Art.all
         arts = allArts.select{|art| art.review && art.subfolder.mainfolder_id == mainfolder.id}
         return arts.count
      end

      def getMainfolderArt(mainfolder)
         allSubfolders = mainfolder.subfolders.order("updated_on desc", "created_on desc")
         value = nil
         if(allSubfolders.count > 0)
            subfolders = allSubfolders.select{|subfolder| !subfolder.privatesubfolder}
            value = getSubfolderArt(subfolders.first)
         end
         return value
      end

      def musicCommons(type)
         galleryFound = Gallery.find_by_id(params[:id])
         if(galleryFound)
            if(current_user && current_user.id == galleryFound.user.id)
               if(galleryFound.music_on)
                  galleryFound.music_on = false
               else
                  galleryFound.music_on = true
               end
               @gallery = galleryFound
               @gallery.save
               redirect_to user_gallery_path(@gallery.user, @gallery)
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userGalleries = userFound.galleries.order("updated_on desc, created_on desc")
               galleriesReviewed = userGalleries.select{|gallery| (current_user && gallery.user_id == current_user.id) || (checkBookgroupStatus(gallery))}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allGalleries = Gallery.order("updated_on desc, created_on desc")
            galleriesReviewed = allGalleries.select{|gallery| (current_user && gallery.user_id == current_user.id) || (checkBookgroupStatus(gallery))}
         end
         @galleries = Kaminari.paginate_array(galleriesReviewed).page(getGalleryParams("Page")).per(10)
      end

      def optional
         value = getGalleryParams("User")
         return value
      end

      def editCommons(type)
         galleryFound = Gallery.find_by_id(getGalleryParams("Id"))
         if(galleryFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == galleryFound.user_id) || logged_in.pouch.privilege == "Admin"))
               galleryFound.updated_on = currentTime
               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               #Allows us to select the user who can view the gallery
               gviewers = Gviewer.order("created_on desc")
               @gviewers = gviewers
               @gallery = galleryFound
               @user = User.find_by_vname(galleryFound.user.vname)
               if(type == "update")
                  if(@gallery.update_attributes(getGalleryParams("Gallery")))
                     flash[:success] = "Gallery #{@gallery.name} was successfully updated."
                     redirect_to user_gallery_path(@gallery.user, @gallery)
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
         galleryFound = Gallery.find_by_name(getGalleryParams("Id"))
         if(galleryFound)
            removeTransactions
            if((current_user && ((galleryFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(galleryFound))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @gallery = galleryFound

               #Come back to this when subsheets is added
               mainfolders = galleryFound.mainfolders
               @mainfolders = Kaminari.paginate_array(mainfolders).page(getGalleryParams("Page")).per(10)
               allFolders = Subfolder.all
               subfolders = allFolders.select{|subfolder| subfolder.mainfolder.gallery_id == @gallery.id}
               @subfolders = subfolders.count
               allArts = Art.all
               arts = allArts.select{|art| art.reviewed && art.subfolder.mainfolder.gallery_id == @gallery.id}
               @arts = arts.count
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == galleryFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @gallery.destroy
                     flash[:success] = "#{@gallery.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to galleries_list_path
                     else
                        redirect_to user_galleries_path(galleryFound.user)
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
               removeTransactions
               allMode = Maintenancemode.find_by_id(1)
               galleryMode = Maintenancemode.find_by_id(14)
               if(allMode.maintenance_on || galleryMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/galleries/maintenance"
                     end
                  end
               else
                  indexCommons
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
                  userFound = User.find_by_vname(getGalleryParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newGallery = logged_in.galleries.new
                        if(type == "create")
                           newGallery = logged_in.galleries.new(getGalleryParams("Gallery"))
                           newGallery.created_on = currentTime
                           newGallery.updated_on = currentTime
                        end
                        galleryCount = logged_in.galleries.count
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        #Allows us to select the user who can view the gallery
                        gviewers = Gviewer.order("created_on desc")
                        @gviewers = gviewers

                        @gallery = newGallery
                        @user = userFound

                        if(type == "create")
                           gallerycost = Fieldcost.find_by_name("Gallery")
                           if(galleryCount > 0 && logged_in.pouch.amount - gallerycost.amount >= 0)
                              if(@gallery.save)
                                 logged_in.pouch.amount -= gallerycost.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 flash[:success] = "#{@gallery.name} was successfully created."
                                 redirect_to user_gallery_path(@user, @gallery)
                              else
                                 render "new"
                              end
                           elsif(galleryCount == 0)
                              if(@gallery.save)
                                 flash[:success] = "#{@gallery.name} was successfully created."
                                 redirect_to user_gallery_path(@user, @gallery)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create gallery!"
                              redirect_to user_path(logged_in.id)
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
            elsif(type == "music")
               if(current_user && current_user.pouch.privilege == "Admin")
                  musicCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  galleryMode = Maintenancemode.find_by_id(14)
                  if(allMode.maintenance_on || galleryMode.maintenance_on)
                     if(allMode.maintenance_on)
                        #the render section
                        render "/start/maintenance"
                     else
                        render "/galleries/maintenance"
                     end
                  else
                     musicCommons(type)
                  end
               end
            elsif(type == "list")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allGalleries = Gallery.order("updated_on desc, created_on desc")
                  @galleries = allGalleries.page(getGalleryParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
