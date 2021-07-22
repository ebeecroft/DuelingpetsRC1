module ArtsHelper

   private
      def getArtParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "ArtId")
            value = params[:art_id]
         elsif(type == "Subfolder")
            value = params[:subfolder_id]
         elsif(type == "Art")
            value = params.require(:art).permit(:title, :description, :image, :remote_image_url, :image_cache,
            :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache, :bookgroup_id)
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
            newTransaction.econattr = "Content"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Art"
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

      def updateGallery(subfolder)
         subfolder.updated_on = currentTime
         @subfolder = subfolder
         @subfolder.save
         mainfolder = Mainfolder.find_by_id(@subfolder.mainfolder_id)
         mainfolder.updated_on = currentTime
         @mainfolder = mainfolder
         @mainfolder.save
         gallery = Gallery.find_by_id(@mainfolder.gallery_id)
         gallery.updated_on = currentTime
         @gallery = gallery
         @gallery.save
      end

      def editCommons(type)
         artFound = Art.find_by_id(getArtParams("Id"))
         if(artFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == artFound.user_id) || logged_in.pouch.privilege == "Admin"))
               artFound.updated_on = currentTime
               artFound.reviewed = false

               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               @art = artFound
               @subfolder = Subfolder.find_by_id(artFound.subfolder.id)
               if(type == "update")
                  if(@art.update_attributes(getArtParams("Art")))
                     updateGallery(@subfolder)
                     flash[:success] = "Art #{@art.title} was successfully updated."
                     redirect_to subfolder_art_path(@art.subfolder, @art)
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
         artFound = Art.find_by_id(getArtParams("Id"))
         if(artFound)
            removeTransactions
            if((current_user && ((artFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (checkBookgroupStatus(artFound)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @art = artFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == artFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     if(artFound.user.gameinfo.startgame)
                        cleanup = Fieldcost.find_by_name("Artcleanup")
                        if(artFound.user.pouch.amount - cleanup.amount >= 0)
                           #Removes the content and decrements the owner's pouch
                           artFound.user.pouch.amount -= cleanup.amount
                           @pouch = artFound.user.pouch
                           @pouch.save
                           economyTransaction("Sink", cleanup.amount, artFound.user.id, "Points")
                           flash[:success] = "#{@art.title} was successfully removed."
                           @art.destroy
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to arts_path
                           else
                              redirect_to mainfolder_subfolder_path(artFound.subfolder.mainfolder, artFound.subfolder)
                           end
                        else
                           flash[:error] = "#{@art.user.vname}'s has insufficient points to remove the artwork!"
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to arts_path
                           else
                              redirect_to mainfolder_subfolder_path(artFound.subfolder.mainfolder, artFound.subfolder)
                           end
                        end
                     else
                        if(logged_in.pouch.privilege == "Admin")
                           flash[:error] = "The artist has not activated the game yet!"
                           redirect_to arts_path
                        else
                           flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                           redirect_to edit_gameinfo_path(logged_in.gameinfo)
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
                  allArts = Art.order("updated_on desc, created_on desc")
                  @arts = Kaminari.paginate_array(allArts).page(getArtParams("Page")).per(10)
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
                  subfolderFound = Subfolder.find_by_id(getArtParams("Subfolder"))
                  if(logged_in && subfolderFound)
                     if(logged_in.id == subfolderFound.user_id || (subfolderFound.collab_mode &&
                        checkBookgroupStatus(subfolderFound.mainfolder.gallery)))
                        if(!subfolderFound.fave_folder)
                           if(logged_in.gameinfo.startgame)
                              newArt = subfolderFound.arts.new
                              if(type == "create")
                                 newArt = subfolderFound.arts.new(getArtParams("Art"))
                                 newArt.created_on = currentTime
                                 newArt.updated_on = currentTime
                                 newArt.user_id = logged_in.id
                              end

                              #Determines the type of bookgroup the user belongs to
                              allGroups = Bookgroup.order("created_on desc")
                              allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                              @group = allowedGroups
                              @subfolder = subfolderFound
                              @art = newArt

                              if(type == "create")
                                 if(@art.save)
                                    arttag = Arttag.new(params[:arttag])
                                    arttag.art_id = @art.id
                                    arttag.tag1_id = 1
                                    @arttag = arttag
                                    @arttag.save
                                    updateGallery(@art.subfolder)
                                    url = "http://www.duelingpets.net/arts/review"
                                    ContentMailer.content_review(@art, "Art", url).deliver_now
                                    flash[:success] = "#{@art.title} was successfully created."
                                    redirect_to subfolder_art_path(@subfolder, @art)
                                 else
                                    render "new"
                                 end
                              end
                           else
                              flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                              redirect_to edit_gameinfo_path(logged_in.gameinfo)
                           end
                        else
                           flash[:error] = "Favorite folders don't support art!"
                           redirect_to root_path
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
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allArts = Art.order("reviewed_on desc, created_on desc")
                  if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                     artsToReview = allArts.select{|art| !art.reviewed}
                     @arts = Kaminari.paginate_array(artsToReview).page(getArtParams("Page")).per(10)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  artFound = Art.find_by_id(getArtParams("ArtId"))
                  if(artFound)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           if(artFound.user.gameinfo.startgame)
                              artFound.reviewed = true
                              artFound.reviewed_on = currentTime
                              updateGallery(artFound.subfolder)

                              #Adds the points to the user's pouch
                              artpoints = Fieldcost.find_by_name("Art")
                              pointsForArt = artpoints.amount
                              @art = artFound
                              @art.save
                              pouch = Pouch.find_by_user_id(@art.user_id)
                              pouch.amount += pointsForArt
                              @pouch = pouch
                              @pouch.save
                              economyTransaction("Source", pointsForArt, artFound.user.id, "Points")
                              ContentMailer.content_approved(@art, "Art", pointsForArt).deliver_now
                              flash[:success] = "#{@art.user.vname}'s art #{@art.title} was approved."
                              redirect_to arts_review_path
                           else
                              flash[:error] = "The artist hasn't started the game yet!"
                              redirect_to arts_review_path
                           end
                        else
                           @art = artFound
                           ContentMailer.content_denied(@art, "Art").deliver_now
                           flash[:success] = "#{@art.user.vname}'s art #{@art.title} was denied."
                           redirect_to arts_review_path
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
