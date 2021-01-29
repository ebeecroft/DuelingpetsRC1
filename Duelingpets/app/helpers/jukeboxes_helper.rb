module JukeboxesHelper

   private
      def getJukeboxParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "JukeboxId")
            value = params[:jukebox_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Jukebox")
            value = params.require(:jukebox).permit(:name, :description, :bookgroup_id, :privatejukebox,
            :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache, :gviewer_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getMainsheetMusic(mainsheet)
         allSubsheets = mainsheet.subsheets.order("updated_on desc", "created_on desc")
         value = nil
         if(allSubsheets.count > 0)
            subsheets = allSubsheets.select{|subsheet| !subsheet.privatesubsheet}
            value = getSubsheetMusic(subsheets.first)
         end
         return value
      end

      def musicCommons(type)
         jukeboxFound = Jukebox.find_by_id(params[:id])
         if(jukeboxFound)
            if(current_user && current_user.id == jukeboxFound.user.id)
               if(jukeboxFound.music_on)
                  jukeboxFound.music_on = false
               else
                  jukeboxFound.music_on = true
               end
               @jukebox = jukeboxFound
               @jukebox.save
               redirect_to user_jukebox_path(@jukebox.user, @jukebox)
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userJukeboxes = userFound.jukeboxes.order("updated_on desc, created_on desc")
               jukeboxesReviewed = userJukeboxes.select{|jukebox| (current_user && jukebox.user_id == current_user.id) || (checkBookgroupStatus(jukebox))}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allJukeboxes = Jukebox.order("updated_on desc, created_on desc")
            jukeboxesReviewed = allJukeboxes.select{|jukebox| (current_user && jukebox.user_id == current_user.id) || (checkBookgroupStatus(jukebox))}
         end
         @jukeboxes = Kaminari.paginate_array(jukeboxesReviewed).page(getJukeboxParams("Page")).per(10)
      end

      def optional
         value = getJukeboxParams("User")
         return value
      end

      def editCommons(type)
         jukeboxFound = Jukebox.find_by_id(getJukeboxParams("Id"))
         if(jukeboxFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == jukeboxFound.user_id) || logged_in.pouch.privilege == "Admin"))
               jukeboxFound.updated_on = currentTime
               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               #Allows us to select the user who can view the jukebox
               gviewers = Gviewer.order("created_on desc")
               @gviewers = gviewers
               @jukebox = jukeboxFound
               @user = User.find_by_vname(jukeboxFound.user.vname)
               if(type == "update")
                  if(@jukebox.update_attributes(getJukeboxParams("Jukebox")))
                     flash[:success] = "Jukebox #{@jukebox.name} was successfully updated."
                     redirect_to user_jukebox_path(@jukebox.user, @jukebox)
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
         jukeboxFound = Jukebox.find_by_name(getJukeboxParams("Id"))
         if(jukeboxFound)
            removeTransactions
            if((current_user && ((jukeboxFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(jukeboxFound))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @jukebox = jukeboxFound

               #Come back to this when subsheets is added
               mainsheets = jukeboxFound.mainsheets
               @mainsheets = Kaminari.paginate_array(mainsheets).page(getJukeboxParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == jukeboxFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @jukebox.destroy
                     flash[:success] = "#{@jukebox.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to jukeboxes_list_path
                     else
                        redirect_to user_jukeboxes_path(jukeboxFound.user)
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
               removeTransactions
               allMode = Maintenancemode.find_by_id(1)
               jukeboxMode = Maintenancemode.find_by_id(11)
               if(allMode.maintenance_on || jukeboxMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/jukeboxes/maintenance"
                     end
                  end
               else
                  indexCommons
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
                  userFound = User.find_by_vname(getJukeboxParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newJukebox = logged_in.jukeboxes.new
                        if(type == "create")
                           newJukebox = logged_in.jukeboxes.new(getJukeboxParams("Jukebox"))
                           newJukebox.created_on = currentTime
                           newJukebox.updated_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        #Allows us to select the user who can view the jukebox
                        gviewers = Gviewer.order("created_on desc")
                        @gviewers = gviewers

                        @jukebox = newJukebox
                        @user = userFound

                        if(type == "create")
                           jukeboxcost = Fieldcost.find_by_name("Jukebox")
                           if(logged_in.pouch.amount - jukeboxcost.amount >= 0)
                              if(@jukebox.save)
                                 logged_in.pouch.amount -= jukeboxcost.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 flash[:success] = "#{@jukebox.name} was successfully created."
                                 redirect_to user_jukebox_path(@user, @jukebox)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create jukebox!"
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
            elsif(type == "music")
               if(current_user && current_user.pouch.privilege == "Admin")
                  musicCommons(type)
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
                     musicCommons(type)
                  end
               end
            elsif(type == "list")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allJukeboxes = Jukebox.order("updated_on desc, created_on desc")
                  @jukeboxes = allJukeboxes.page(getJukeboxParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
