module UsersHelper

   private
      def getUserParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "User")
            value = params.require(:user).permit(:imaginaryfriend, :email,
            :country, :country_timezone, :military_time, :birthday, :login_id,
            :vname, :password, :password_confirmation, :shared)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getReferrals(user)
         allReferrals = Referral.order("created_on desc")
         value = allReferrals.select{|referral| referral.referred_by_id == user.id}
         return value.count
      end

      def getBanned(user)
         allBanned = Suspendedtimelimit.order("created_on desc")
         user = allBanned.select{|banned| banned.user_id == user.id}
         return user
      end
      
      def getPagereturn(pagetype, content)
         if(pagetype == "Home")
            redirect_to root_path
         elsif(pagetype == "Hoard")
            redirect_to dragonhoards_path
         elsif(pagetype == "User")
            redirect_to user_path(content)
         elsif(pagetype == "NewOC")
            redirect_to new_user_oc_path(current_user)
         elsif(pagetype == "NewItem")
            redirect_to new_user_item_path(current_user)
         elsif(pagetype == "NewCreature")
            redirect_to new_user_creature_path(current_user)
         elsif(pagetype == "NewMonster")
            redirect_to new_user_monster_path(current_user)
         elsif(pagetype == "Jukebox")
            redirect_to user_jukebox_path(content[0], content[1])
         elsif(pagetype == "Channel")
            redirect_to user_channels_path(content[0], content[1])
         elsif(pagetype == "Gallery")
            redirect_to user_galleries_path(content[0], content[1])
         elsif(pagetype == "Usermain")
            redirect_to users_maintenance_path
         elsif(pagetype == "Blogmain")
            redirect_to blogs_maintenance_path
         elsif(pagetype == "OCmain")
            redirect_to ocs_maintenance_path
         elsif(pagetype == "Itemmain")
            redirect_to items_maintenance_path
         elsif(pagetype == "Monstermain")
            redirect_to monsters_maintenance_path
         elsif(pagetype == "Creaturemain")
            redirect_to creatures_maintenance_path
         elsif(pagetype == "Bookworldmain")
            redirect_to bookworlds_maintenance_path
         elsif(pagetype == "Jukeboxmain")
            redirect_to jukeboxes_maintenance_path
         elsif(pagetype == "Channelmain")
            redirect_to channels_maintenance_path
         elsif(pagetype == "Gallerymain")
            redirect_to galleries_maintenance_path
         end
      end

      def musicCommons(type)
         userFound = User.find_by_id(getUserParams("Id"))
         if(userFound)
            if(current_user && current_user.id == userFound.id)
               userInfo = Userinfo.find_by_user_id(userFound.id)
               if(userInfo.music_on)
                  userInfo.music_on = false
               else
                  userInfo.music_on = true
               end
               @userinfo = userInfo
               @userinfo.save
               redirect_to user_path(@userinfo.user)
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def showCommons(type)
         userFound = User.find_by_vname(getUserParams("Id"))
         if(userFound)
            setLastpageVisited
            #visitTimer(type, userFound)
            #cleanupOldVisits
            @user = userFound
            if(type == "destroy")
               logged_in = current_user
               if(logged_in && ((logged_in.id == userFound.id) || logged_in.pouch.privilege == "Admin"))
                  adminXorCurrentUser = (logged_in.pouch.privilege == "Admin" && logged_in.id != userFound.id) || (!logged_in.pouch.privilege == "Admin" && logged_in.id == userFound.id)
                  if(adminXorCurrentUser)
                     allColors = Colorscheme.all
                     allInfos = Userinfo.all
                     userColors = allColors.select{|colorscheme| colorscheme.user_id == @user.id}
                     if(userColors.size != 0)
                        userColors.each do |colorscheme|
                           infosToChange = allInfos.select{|userinfo| userinfo.colorscheme_id == colorscheme.id}
                           if(infosToChange.size != 0)
                              infosToChange.each do |userinfo|
                                 userinfo.colorscheme_id = 1
                                 @userinfo = userinfo
                                 @userinfo.save
                              end
                           end
                        end
                     end
                     @user.destroy
                     flash[:success] = "#{@user.vname} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to users_path
                     else
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "You cannot delete the main admin account."
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def editCommons(type)
         userFound = User.find_by_vname(getUserParams("Id"))
         if(userFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == userFound.id) || logged_in.pouch.privilege == "Admin"))
               @user = userFound
               if(type == "update")
                  if(@user.update(getUserParams("User")))
                     flash[:success] = "#{@user.vname} was successfully updated."
                     redirect_to user_path(@user)
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
                  allUsers = User.order("joined_on desc").page(getUserParams("Page")).per(9)
                  @users = allUsers
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               removeTransactions
               if(current_user && current_user.pouch.privilege == "Admin")
                  showCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        #the render section
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     showCommons(type)
                  end
               end
            elsif(type == "disableshoutbox" || type == "disablepmbox")
               userFound = User.find_by_id(getUserParams("Id"))
               if(current_user && userFound && current_user.id == userFound.id)
                  box = userFound.shoutbox
                  if(type == "disablepmbox")
                     box = userFound.pmbox
                  end

                  #Sets the box value for shouts and pms
                  if(box.box_open)
                     box.box_open = false
                  else
                     box.box_open = true
                  end

                  #Sets the value of the pmbox and shoutbox
                  @box = box
                  @box.save
                  redirect_to user_path(@box.user)
               else
                  redirect_to root_path
               end
            elsif(type == "music")
               if(current_user && current_user.pouch.privilege == "Admin")
                  musicCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        #the render section
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     musicCommons(type)
                  end
               end
            elsif(type == "extractore")
               userFound = User.find_by_id(getUserParams("Id"))
               if(current_user && userFound && userFound.id == current_user.id)
                  if(userFound.pouch.dreyterriumamount > 0)
                     hoard = Dragonhoard.find_by_id(1)
                     hoard.dreyterrium_extracted += 1
                     if(hoard.dreyterrium_extracted < hoard.dreyterriumchange)
                        #Gives the player points based on the current value
                        points = hoard.dreyterriumcurrent_value
                        userFound.pouch.amount += points
                        userFound.pouch.dreyterriumamount -= 1
                        @pouch = userFound.pouch
                        @pouch.save
                     else
                        #Flucates the price of dreyterrium
                        hoard.dreyterriumcurrent_value += 1
                        hoard.dreyterrium_extracted = 0
                        points = hoard.dreyterriumcurrent_value
                        userFound.pouch.amount += points
                        userFound.pouch.dreyterriumamount -= 1
                        @pouch = userFound.pouch
                        @pouch.save
                     end
                     @dragonhoard = hoard
                     @dragonhoard.save
                     redirect_to user_path(userFound)
                  else
                     flash[:error] = "You don't have any dreyterrium to extract!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "controlsOn")
               controlvalue = 0
               if(current_user && current_user.pouch.privilege == "Admin")
                  if(current_user.userinfo.admincontrols_on)
                     current_user.userinfo.admincontrols_on = false
                  else
                     current_user.userinfo.admincontrols_on = true
                  end
                  controlvalue = 1
               elsif(current_user && current_user.pouch.privilege == "Reviewer")
                  if(current_user.userinfo.reviewercontrols_on)
                     current_user.userinfo.reviewercontrols_on = false
                  else
                     current_user.userinfo.reviewercontrols_on = true
                  end
                  controlvalue = 1
               elsif(current_user && current_user.pouch.privilege == "Keymaster")
                  if(current_user.userinfo.keymastercontrols_on)
                     current_user.userinfo.keymastercontrols_on = false
                  else
                     current_user.userinfo.keymastercontrols_on = true
                  end
                  controlvalue = 1
               elsif(current_user && current_user.pouch.privilege == "Manager")
                  if(current_user.userinfo.managercontrols_on)
                     current_user.userinfo.managercontrols_on = false
                  else
                     current_user.userinfo.managercontrols_on = true
                  end
                  controlvalue = 1
               end
               if(controlvalue == 1)
                  @userinfo = current_user.userinfo
                  @userinfo.save
                  redirect_to user_path(current_user)
               else
                  redirect_to root_path
               end
            elsif(type == "muteAudio")
               if(current_user)
                  if(current_user.userinfo.mute_on)
                     current_user.userinfo.mute_on = false
                  else
                     current_user.userinfo.mute_on = true
                  end
                  @userinfo = current_user.userinfo
                  @userinfo.save
                  pagetype = params[:pageType]
                  pagecontent = params[:pageContent]
                  getPagereturn(pagetype, pagecontent)
               end
            end
         end
      end
end
