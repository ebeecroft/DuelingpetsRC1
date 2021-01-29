module SoundsHelper

   private
      def getSoundParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "SoundId")
            value = params[:sound_id]
         elsif(type == "Subsheet")
            value = params[:subsheet_id]
         elsif(type == "Sound")
            value = params.require(:sound).permit(:title, :description, :ogg, :remote_ogg_url, :ogg_cache,
            :mp3, :remote_mp3_url, :mp3_cache, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def updateJukebox(subsheet)
         subsheet.updated_on = currentTime
         @subsheet = subsheet
         @subsheet.save
         mainsheet = Mainsheet.find_by_id(@subsheet.mainsheet_id)
         mainsheet.updated_on = currentTime
         @mainsheet = mainsheet
         @mainsheet.save
         jukebox = Jukebox.find_by_id(@mainsheet.jukebox_id)
         jukebox.updated_on = currentTime
         @jukebox = jukebox
         @jukebox.save
      end

      def editCommons(type)
         soundFound = Sound.find_by_id(getSoundParams("Id"))
         if(soundFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == soundFound.user_id) || logged_in.pouch.privilege == "Admin"))
               soundFound.updated_on = currentTime
               soundFound.reviewed = false

               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               @sound = soundFound
               @subsheet = Subsheet.find_by_id(soundFound.subsheet.id)
               if(type == "update")
                  if(@sound.update_attributes(getSoundParams("Sound")))
                     updateJukebox(@subsheet)
                     flash[:success] = "Sound #{@sound.title} was successfully updated."
                     redirect_to subsheet_sound_path(@sound.subsheet, @sound)
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
         soundFound = Sound.find_by_id(getSoundParams("Id"))
         if(soundFound)
            removeTransactions
            if((current_user && ((soundFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (checkBookgroupStatus(soundFound)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @sound = soundFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == soundFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @sound.destroy
                     flash[:success] = "#{soundFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to sounds_path
                     else
                        redirect_to mainsheet_subsheet_path(soundFound.subsheet.mainsheet, soundFound.subsheet)
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
                  allSounds = Sound.order("updated_on desc, created_on desc")
                  @sounds = Kaminari.paginate_array(allSounds).page(getSoundParams("Page")).per(10)
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
                  subsheetFound = Subsheet.find_by_id(getSoundParams("Subsheet"))
                  if(logged_in && subsheetFound)
                     if(logged_in.id == subsheetFound.user_id || (subsheetFound.collab_mode &&
                        checkBookgroupStatus(subsheetFound.mainsheet.jukebox)))
                        if(!subsheetFound.fave_folder)
                           newSound = subsheetFound.sounds.new
                           if(type == "create")
                              newSound = subsheetFound.sounds.new(getSoundParams("Sound"))
                              newSound.created_on = currentTime
                              newSound.updated_on = currentTime
                              newSound.user_id = logged_in.id
                           end

                           #Determines the type of bookgroup the user belongs to
                           allGroups = Bookgroup.order("created_on desc")
                           allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                           @group = allowedGroups
                           @sound = newSound
                           @subsheet = subsheetFound

                           if(type == "create")
                              if(@sound.save)
                                 soundtag = Soundtag.new(params[:soundtag])
                                 soundtag.sound_id = @sound.id
                                 soundtag.tag1_id = 1
                                 @soundtag = soundtag
                                 @soundtag.save
                                 updateJukebox(@sound.subsheet)
                                 url = "http://www.duelingpets.net/sounds/review"
                                 ContentMailer.content_review(@sound, "Sound", url).deliver_now
                                 flash[:success] = "#{@sound.title} was successfully created."
                                 redirect_to subsheet_sound_path(@subsheet, @sound)
                              else
                                 render "new"
                              end
                           end
                        else
                           flash[:error] = "Favorite folders don't support music!"
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
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allSounds = Sound.order("reviewed_on desc, created_on desc")
                  if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                     soundsToReview = allSounds.select{|sound| !sound.reviewed}
                     @sounds = Kaminari.paginate_array(soundsToReview).page(getSoundParams("Page")).per(10)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  soundFound = Sound.find_by_id(getSoundParams("SoundId"))
                  if(soundFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           soundFound.reviewed = true
                           soundFound.reviewed_on = currentTime
                           updateJukebox(soundFound.subsheet)

                           #Adds the points to the user's pouch
                           soundpoints = Fieldcost.find_by_name("Sound")
                           pointsForSound = soundpoints.amount
                           @sound = soundFound
                           @sound.save
                           pouch = Pouch.find_by_user_id(@sound.user_id)
                           pouch.amount += pointsForSound
                           @pouch = pouch
                           @pouch.save

                           #Adds the sound points to the economy
                           newTransaction = Economy.new(params[:economy])
                           newTransaction.econtype = "Content"
                           newTransaction.content_type = "Sound"
                           newTransaction.name = "Source"
                           newTransaction.amount = pointsForSound
                           newTransaction.user_id = soundFound.user_id
                           newTransaction.created_on = currentTime
                           @economytransaction = newTransaction
                           @economytransaction.save

                           ContentMailer.content_approved(@sound, "Sound", pointsForSound).deliver_now
                           #allWatches = Watch.all
                           #watchers = allWatches.select{|watch| (((watch.watchtype.name == "Arts" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Artsounds" || watch.watchtype.name == "Artmovies")) || (watch.watchtype.name == "Maincontent" || watch.watchtype.name == "All")) && watch.from_user.id != @art.user_id}
                           #if(watchers.count > 0)
                           #   watchers.each do |watch|
                           #      UserMailer.new_art(@art, watch).deliver
                           #   end
                           #end
                           value = "#{@sound.user.vname}'s sound #{@sound.title} was approved."
                        else
                           @sound = soundFound
                           ContentMailer.content_denied(@sound, "Sound").deliver_now
                           value = "#{@sound.user.vname}'s sound #{@sound.title} was denied."
                        end
                        flash[:success] = value
                        redirect_to sounds_review_path
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
