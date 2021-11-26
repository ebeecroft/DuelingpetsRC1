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

      def getTagname(tagid)
         tag = Tag.find_by_id(tagid)
         return tag.name
      end
      
      def showpage
         artFound = Art.find_by_id(getArtParams("Id"))
         artValid = artFound && ((current_user && current_user.id == artFound.user.id) || (artFound.reviewed && checkBookgroupStatus(artFound)))
         staff = (current_user && (current_user.pouch.privilege == "Admin" || current_user.pouch.privilege == "Reviewer" || current_user.pouch.privilege == "Keymaster"))
         
         #fix bookgroup later
         if(artFound && (artValid || current_user.pouch.privilege == "Admin" || (staff && checkBookgroupStatus(artFound))))
            removeTransactions
            #visitTimer(type, blogFound)
            #cleanupOldVisits
            @art = artFound
         else
            if(!artFound)
               flash[:error] = "Art doesn't exist!"
            elsif(!artFound.reviewed)
               flash[:error] = "Art is not accessible to guests!"
            elsif(!checkBookgroupStatus(artFound))
               flash[:error] = "User can't view this content!"
            else
               flash[:error] = "User doesn't have permission to view this art!"
            end
            redirect_to root_path
         end
      end
      
      def updateGallery(subfolder)
         #Updates the data for create and edit actions
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
      
      def callMaintenance(type)
         #removeTransactions
         allMode = Maintenancemode.find_by_id(1)
         galleryMode = Maintenancemode.find_by_id(14)
         if(allMode.maintenance_on || elementMode.maintenance_on)
            if(current_user && current_user.pouch.privilege == "Admin")
               if(type == "show")
                  showpage
               else
                  editCommons(type)
               end
            else
               if(allMode.maintenance_on)
                  render "/start/maintenance"
               else
                  render "/galleries/maintenance"
               end
            end
         else
            if(type == "index")
               indexpage
            elsif(type == "show")
               showpage
            elsif(type == "new" || type == "create")
               createCommons(type)
            elsif(type == "addtag")
               addTag
            elsif(type == "removetag")
               removeTag
            else
               editCommons(type)
            end
         end
      end
      
      def createCommons(type)
         logged_in = current_user
         subfolderFound = Subfolder.find_by_id(getArtParams("Subfolder"))
         validSubfolder = (logged_in && subfolderFound && (logged_in.id == subfolderFound.user_id || subfolderFound.collab_mode && checkBookgroupStatus(subfolderFound.mainfolder.gallery)))
         if(validSubfolder && logged_in.gameinfo.startgame && !subfolderFound.fave_folder)
            #Builds the new artwork
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

            #Stores the artwork and sends it to the review team
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
            if(!subfolderFound)
               flash[:error] = "That subfolder does not exist!"
            elsif(!logged_in)
               flash[:error] = "Only logged in users can create content!"
            elsif(logged_in.id != subfolderFound.user_id && !subfolderFound.collab_mode)
               flash[:error] = "User can't upload art to a private subfolder!"
            #elsif(subfolderFound.collab_mode && !checkBookgroupStatus(subfolderFound.mainfolder.gallery))
            #   flash[:error] = "User can't 
            elsif(!logged_in.gameinfo.startgame)
               flash[:error] = "{logged_in.vname} has not activated their game yet!"
            elsif(subfolderFound.fave_folder)
               flash[:error] = "User can't upload art to a favorite folder!"
            else
               flash[:error] = "Page just hit an unknown error, redirecting now!"
            end
            redirect_to root_path
         end
      end
      
      def editCommons(type)
         logged_in = current_user
         artFound = Art.find_by_id(getArtParams("Id"))
         staff = (logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Reviewer"))
         if(artFound && logged_in && (staff || logged_in.id == artFound.user_id))
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
            elsif(type == "destroy")
               price = Fieldcost.find_by_name("Artcleanup")
               if(staff || (artFound.user.gameinfo.startgame && artFound.user.pouch.amount - price.amount >= 0))
                  if(!staff)
                     artFound.user.pouch.amount -= price.amount #Remember to come back later to change to emeralds
                     @pouch = artFound.user.pouch
                     @pouch.save
                     economyTransaction("Sink", price.amount, artFound.user.id, "Points")
                  end
                  @art.destroy
                  flash[:success] = "#{@art.title} was successfully removed."
                  if(logged_in.pouch.privilege == "Admin")
                     redirect_to arts_path
                  else
                     redirect_to mainfolder_subfolder_path(artFound.subfolder.mainfolder, artFound.subfolder)
                  end
               else
                  if(!artFound.user.gameinfo.startgame)
                     flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                  else
                     flash[:error] = "#{@art.user.vname}'s has insufficient points to remove the art!"
                  end
                  redirect_to root_path
               end
            end
         else
            if(!artFound)
               flash[:error] = "The art does not exist!"
            else
               flash[:error] = "User doesn't have permission to edit this art!"
            end
            redirect_to root_path
         end
      end

      def addTag
         logged_in = current_user
         arttagFound = Arttag.find_by_id(getArttagParams("ArttagId")) #Generic
         tag = Tag.find_by_name(params[:arttag][:name]) #Tag to use #Generic
         location = params[:arttag][:taglocation] #Tag1-30 #Generic
         validTag = (arttagFound && logged_in && tag && location && logged_in.pouch.privilege == "Admin" || logged_in.id == arttagFound.art.user_id)
         if(validTag)
            #Gets replaced by array
            if(location == "tag1")
               arttag.tag1_id = tag.id
            elsif(location == "tag2")
               arttag.tag2_id = tag.id
            elsif(location == "tag3")
               arttag.tag3_id = tag.id
            elsif(location == "tag4")
               arttag.tag4_id = tag.id
            elsif(location == "tag5")
               arttag.tag5_id = tag.id
            elsif(location == "tag6")
               arttag.tag6_id = tag.id
            elsif(location == "tag7")
               arttag.tag7_id = tag.id
            elsif(location == "tag8")
               arttag.tag8_id = tag.id
            elsif(location == "tag9")
               arttag.tag9_id = tag.id
            elsif(location == "tag10")
               arttag.tag10_id = tag.id
            elsif(location == "tag11")
               arttag.tag11_id = tag.id
            elsif(location == "tag12")
               arttag.tag12_id = tag.id
            end
            @arttag = arttag
            @arttag.save
            flash[:success] = "Tag #{tagFound.name} was added at #{location} location!"
            redirect_to subfolder_art_path(@arttag.art.subfolder, @arttag.art)
         else
            if(!arttagFound)
               flash[:error] = "Arttag doesn't exist"
            elsif(!tag)
               flash[:error] = "Tag does not exist!"
            elsif(!location)
               flash[:error] = "Tag location was invalid!"
            elsif(!logged_in)
               flash[:error] = "You must be logged in to use this feature!"
            else
               flash[:error] = "Only the Admin or the Owner can add tags to this art!"
            end
            redirect_to root_path
         end
      end

      def removeTag
         logged_in = current_user
         arttagFound = Arttag.find_by_id(getArttagParams("ArttagId"))
         tag = Tag.find_by_name(params[:tagid]) #Tag to use
         validTag = (arttagFound && logged_in && tag && logged_in.pouch.privilege == "Admin" || logged_in.id == arttagFound.art.user_id)
         if(validTag)
            #Gets replaced by array
            if(arttag.tag1_id == tag.id)
               arttag.tag1_id = nil
            elsif(arttag.tag2_id == tag.id)
               arttag.tag2_id = nil
            elsif(arttag.tag3_id == tag.id)
               arttag.tag3_id = nil
            elsif(arttag.tag4_id == tag.id)
               arttag.tag4_id = nil
            elsif(arttag.tag5_id == tag.id)
               arttag.tag5_id = nil
            elsif(arttag.tag6_id == tag.id)
               arttag.tag6_id = nil
            elsif(arttag.tag7_id == tag.id)
               arttag.tag7_id = nil
            elsif(arttag.tag8_id == tag.id)
               arttag.tag8_id = nil
            elsif(arttag.tag9_id == tag.id)
               arttag.tag9_id = nil
            elsif(arttag.tag10_id == tag.id)
               arttag.tag10_id = nil
            elsif(arttag.tag11_id == tag.id)
               arttag.tag11_id = nil
            elsif(arttag.tag12_id == tag.id)
               arttag.tag12_id = nil
            end
            @arttag = arttagFound
            @arttag.save
            flash[:success] = "Tag #{getTagname(tag)} was successfully removed!"
            redirect_to subfolder_art_path(@arttag.art.subfolder, @arttag.art)
         else
            if(!arttagFound)
               flash[:error] = "Arttag doesn't exist"
            elsif(!tag)
               flash[:error] = "Tag does not exist!"
            elsif(!logged_in)
               flash[:error] = "You must be logged in to use this feature!"
            else
               flash[:error] = "Only the Admin or the Owner can add tags to this art!"
            end
            redirect_to root_path
         end
      end

      def mode(type)
         removeTransactions
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               #Staff only
               logged_in = current_user
               staff = (logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Reviewer"))
               if(staff)
                  allArts = Art.order("updated_on desc, created_on desc")
                  @arts = Kaminari.paginate_array(allArts).page(getArtParams("Page")).per(10)
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create" || type == "edit" || type == "update" || type == "destroy")
               #Login only
               callMaintenance(type)
            elsif(type == "show")
               #Guest Accessible
               callMaintenance(type)
            elsif(type == "addtag" || type == "removetag")
               #Login only
               callMaintenance(type)
            elsif(type == "review" || type == "approve" || type == "deny")
               #Staff only
               staff = (current_user && (current_user.pouch.privilege == "Admin" || current_user.pouch.privilege == "Keymaster" || current_user.pouch.privilege == "Reviewer"))
               if(staff)
                  if(type == "review")
                     allArts = Art.order("reviewed_on desc, created_on desc")
                     artsToReview = allArts.select{|art| !art.reviewed}
                     @arts = Kaminari.paginate_array(artsToReview).page(getArtParams("Page")).per(9)
                  else
                     artFound = Art.find_by_id(getArtParams("ArtId"))
                     if(artFound && type == "approve")
                        if(artFound.points_earned)
                           artFound.reviewed = true
                           artFound.reviewed_on = currentTime
                           updateGallery(artFound.subfolder)
                           @art = artFound
                           @art.save
                           ContentMailer.content_approved(@art, "Art", 0).deliver_now
                           flash[:success] = "#{@art.user.vname}'s art #{@art.title} was approved."
                           redirect_to arts_review_path
                        else
                           artFound.points_earned = true
                           if(artFound.user.gameinfo.startgame)
                              artFound.reviewed = true
                              artFound.reviewed_on = currentTime
                              updateGallery(artFound.subfolder)
                              @art = artFound
                              @art.save
                              
                              #Adds the points to the user's pouch
                              artpoints = Fieldcost.find_by_name("Art")
                              pointsForArt = artpoints.amount
                              pouch = Pouch.find_by_user_id(@art.user_id)
                              pouch.amount += pointsForArt
                              @pouch = pouch
                              @pouch.save
                              
                              #Lets the user know there content is approved
                              economyTransaction("Source", pointsForArt, artFound.user.id, "Points")
                              ContentMailer.content_approved(@art, "Art", pointsForArt).deliver_now
                              flash[:success] = "#{@art.user.vname}'s art #{@art.title} was approved."
                              redirect_to arts_review_path
                           else
                              flash[:error] = "{artFound.user.vname} has not activated their game yet!"
                              redirect_to arts_review_path
                           end
                        end                           
                     elsif(artFound && type == "deny")
                        @art = artFound
                        ContentMailer.content_denied(@art, "Art").deliver_now
                        flash[:success] = "#{@art.user.vname}'s art #{@element.name} was denied."
                        redirect_to arts_review_path
                     else
                        flash[:error] = "Art does not exist!"
                        redirect_to root_path
                     end
                  end
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            end
         end
      end
end
