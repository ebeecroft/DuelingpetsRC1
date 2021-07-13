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
      
      def economyTransaction(type, points, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Upgrades"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "User"
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

      def getCurLimit(type, user, result)
         upgrade = Userupgrade.find_by_name(type)
         if(type == "Pouch")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free1 + user.pouch.pouchslot.member1))
            level = (user.pouch.amount.to_s + "/" + max.to_s)
         elsif(type == "Emerald")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free2 + user.pouch.pouchslot.member2))
            if(result == "Limit")
               level = (user.pouch.emeraldamount.to_s + "/" + max.to_s)
            else
               level = max - user.pouch.emeraldamount
            end
         elsif(type == "Dreyore")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free3 + user.pouch.pouchslot.member3))
            if(result == "Limit")
               level = (user.pouch.dreyoreamount.to_s + "/" + max.to_s)
            else
               level = max - user.pouch.dreyoreamount
            end
         elsif(type == "OCup")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free5 + user.pouch.pouchslot.member5))
            if(result == "Limit")
               level = (user.ocs.count.to_s + "/" + max.to_s)
            else
               level = max - user.ocs.count
            end
         elsif(type == "Blog")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free6 + user.pouch.pouchslot.member6))
            if(result == "Limit")
               level = (user.blogs.count.to_s + "/" + max.to_s)
            else
               level = max - user.blogs.count
            end
         elsif(type == "Gallery")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free7 + user.pouch.pouchslot.member7))
            if(result == "Limit")
               level = (user.galleries.count.to_s + "/" + max.to_s)
            else
               level = max - user.galleries.count
            end
         elsif(type == "Book")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free8 + user.pouch.pouchslot.member8))
            if(result == "Limit")
               level = (user.books.count.to_s + "/" + max.to_s)
            else
               level = max - user.books.count
            end
         elsif(type == "Jukebox")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free9 + user.pouch.pouchslot.member9))
            if(result == "Limit")
               level = (user.jukeboxes.count.to_s + "/" + max.to_s)
            else
               level = max - user.jukeboxes.count
            end
         elsif(type == "Channel")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free10 + user.pouch.pouchslot.member10))
            if(result == "Limit")
               level = (user.channels.count.to_s + "/" + max.to_s)
            else
               level = max - user.channels.count
            end
         end
         return level
      end

      def getLimit(type)
         upgrade = Userupgrade.find_by_name(type)
         if(type == "Pouch")
            level = ((current_user.pouch.pouchslot.free1 + current_user.pouch.pouchslot.member1).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Emerald")
            level = ((current_user.pouch.pouchslot.free2 + current_user.pouch.pouchslot.member2).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Dreyore")
            level = ((current_user.pouch.pouchslot.free3 + current_user.pouch.pouchslot.member3).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "OCup")
            level = ((current_user.pouch.pouchslot.free5 + current_user.pouch.pouchslot.member5).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Blog")
            level = ((current_user.pouch.pouchslot.free6 + current_user.pouch.pouchslot.member6).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Gallery")
            level = ((current_user.pouch.pouchslot.free7 + current_user.pouch.pouchslot.member7).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Book")
            level = ((current_user.pouch.pouchslot.free8 + current_user.pouch.pouchslot.member8).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Jukebox")
            level = ((current_user.pouch.pouchslot.free9 + current_user.pouch.pouchslot.member9).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         elsif(type == "Channel")
            level = ((current_user.pouch.pouchslot.free10 + current_user.pouch.pouchslot.member10).to_s + "/" + (upgrade.freecap + upgrade.membercap).to_s)
         end
         return level
      end

      def getPrice(type)
         upgrade = Userupgrade.find_by_name(type)
         if(type == "Pouch")
            level = current_user.pouch.pouchslot.free1 + current_user.pouch.pouchslot.member1
         elsif(type == "Emerald")
            level = current_user.pouch.pouchslot.free2 + current_user.pouch.pouchslot.member2
         elsif(type == "Dreyore")
            level = current_user.pouch.pouchslot.free3 + current_user.pouch.pouchslot.member3
         elsif(type == "OCup")
            level = current_user.pouch.pouchslot.free5 + current_user.pouch.pouchslot.member5
         elsif(type == "Blog")
            level = current_user.pouch.pouchslot.free6 + current_user.pouch.pouchslot.member6
         elsif(type == "Gallery")
            level = current_user.pouch.pouchslot.free7 + current_user.pouch.pouchslot.member7
         elsif(type == "Book")
            level = current_user.pouch.pouchslot.free8 + current_user.pouch.pouchslot.member8
         elsif(type == "Jukebox")
            level = current_user.pouch.pouchslot.free9 + current_user.pouch.pouchslot.member9
         elsif(type == "Channel")
            level = current_user.pouch.pouchslot.free10 + current_user.pouch.pouchslot.member10
         end
         cost = upgrade.price * (level + 1)
         return cost
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
                  if(userFound.pouch.dreyoreamount > 0)
                     #Determines what ore type we are looking at
                     oreFound = ""
                     if(userFound.pouch.firstdreyore)
                        oreFound = Dreyore.find_by_name("Newbie")
                     else
                        oreFound = Dreyore.find_by_name("Monster")
                     end
                     
                     #Determines what to do with the current ore
                     oreFound.extracted += 1
                     if(oreFound.extracted < oreFound.change)
                        #Gives the player points based on the current value
                        points = oreFound.price
                        userFound.pouch.amount += points
                        userFound.pouch.dreyoreamount -= 1
                        if(userFound.pouch.dreyoreamount == 0 && userFound.pouch.firstdreyore)
                           userFound.pouch.firstdreyore = false
                        end
                        economyTransaction("Source", points, userFound.id, "Points")
                        @pouch = userFound.pouch
                        @pouch.save
                     else
                        #Flucates the price of dreyore
                        oreFound.extracted = 0
                        oreFound.price += 1
                        points = oreFound.price
                        userFound.pouch.amount += points
                        userFound.pouch.dreyoreamount -= 1
                        if(userFound.pouch.dreyoreamount == 0 && userFound.pouch.firstdreyore)
                           userFound.pouch.firstdreyore = false
                        end
                        economyTransaction("Source", points, userFound.id, "Points")
                        @pouch = userFound.pouch
                        @pouch.save
                     end
                     @ore = oreFound
                     @ore.save
                     redirect_to user_path(userFound)
                  else
                     flash[:error] = "You don't have any dreyore to extract!"
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
            elsif(type == "upgrade" || type == "upgradeinfo" || type == "upgradepost")
               logged_in = current_user
               if(logged_in)
                  @user = logged_in
                  if(type == "upgradepost")
                     upgradetype = params[:upgrade][:upgradetype]
                     upgradechoice = params[:upgrade][:choice]
                     upgrade = ""
                     level = 0
                     cap = 0
                     memlevel = 0
                     if(upgradechoice.to_i == 1) #Free
                        if(upgradetype.to_i == 1) #Pouch
                           level = @user.pouch.pouchslot.free1 += 1
                           upgrade = "Pouch"
                        elsif(upgradetype.to_i == 2) #Emeralds
                           level = @user.pouch.pouchslot.free2 += 1
                           upgrade = "Emerald"
                        #Scildons between these two
                        elsif(upgradetype.to_i == 3) #Dreyore
                           level = @user.pouch.pouchslot.free3 += 1
                           upgrade = "Dreyore"
                        elsif(upgradetype.to_i == 4) #OC
                           level = @user.pouch.pouchslot.free5 += 1
                           upgrade = "OCup"
                        elsif(upgradetype.to_i == 5) #Blog
                           level = @user.pouch.pouchslot.free6 += 1
                           upgrade = "Blog"
                        elsif(upgradetype.to_i == 6) #Gallery
                           level = @user.pouch.pouchslot.free7 += 1
                           upgrade = "Gallery"
                        elsif(upgradetype.to_i == 7) #Book
                           level = @user.pouch.pouchslot.free8 += 1
                           upgrade = "Book"
                        elsif(upgradetype.to_i == 8) #Jukebox
                           level = @user.pouch.pouchslot.free9 += 1
                           upgrade = "Jukebox"
                        elsif(upgradetype.to_i == 9) #Channel
                           level = @user.pouch.pouchslot.free10 += 1
                           upgrade = "Channel"
                        end
                     else #Member
                        if(upgradetype.to_i == 1) #Pouch
                           memlevel = @user.pouch.pouchslot.member1 += 1
                           freelevel = @user.pouch.pouchslot.free1
                           level = memlevel + freelevel
                           upgrade = "Pouch"
                        elsif(upgradetype.to_i == 2) #Emeralds
                           memlevel = @user.pouch.pouchslot.member2 += 1
                           freelevel = @user.pouch.pouchslot.free2
                           level = memlevel + freelevel
                           upgrade = "Emerald"
                        #Scildons between these two
                        elsif(upgradetype.to_i == 3) #Dreyore
                           memlevel = @user.pouch.pouchslot.member3 += 1
                           freelevel = @user.pouch.pouchslot.free3
                           level = memlevel + freelevel
                           upgrade = "Dreyore"
                        elsif(upgradetype.to_i == 4) #OC
                           memlevel = @user.pouch.pouchslot.member5 += 1
                           freelevel = @user.pouch.pouchslot.free5
                           level = memlevel + freelevel
                           upgrade = "OCup"
                        elsif(upgradetype.to_i == 5) #Blog
                           memlevel = @user.pouch.pouchslot.member6 += 1
                           freelevel = @user.pouch.pouchslot.free6
                           level = memlevel + freelevel
                           upgrade = "Blog"
                        elsif(upgradetype.to_i == 6) #Gallery
                           memlevel = @user.pouch.pouchslot.member7 += 1
                           freelevel = @user.pouch.pouchslot.free7
                           level = memlevel + freelevel
                           upgrade = "Gallery"
                        elsif(upgradetype.to_i == 7) #Book
                           memlevel = @user.pouch.pouchslot.member8 += 1
                           freelevel = @user.pouch.pouchslot.free8
                           level = memlevel + freelevel
                           upgrade = "Book"
                        elsif(upgradetype.to_i == 8) #Jukebox
                           memlevel = @user.pouch.pouchslot.member9 += 1
                           freelevel = @user.pouch.pouchslot.free9
                           level = memlevel + freelevel
                           upgrade = "Jukebox"
                        elsif(upgradetype.to_i == 9) #Channel
                           memlevel = @user.pouch.pouchslot.member10 += 1
                           freelevel = @user.pouch.pouchslot.free10
                           level = memlevel + freelevel
                           upgrade = "Channel"
                        end
                     end
                     cupgrade = Userupgrade.find_by_name(upgrade)
                     if((upgradechoice.to_i == 1 && level < cupgrade.freecap) || (upgradechoice.to_i == 2 && memlevel < cupgrade.membercap))
                        cost = cupgrade.price * level
                        if(@user.pouch.amount - cost >= 0)
                           @user.pouch.amount -= cost
                           @pouch = @user.pouch
                           @pouch.save
                           economyTransaction("Sink", cost, @user.id, "Points")
                           #Maybe add a way for the dragonhoard to retrieve these points
                           @pouchslot = @user.pouch.pouchslot
                           @pouchslot.save
                           if(upgradechoice.to_i == 1)
                              flash[:success] = "#{upgrade} is now at free level #{level}"
                           else
                              flash[:success] = "#{upgrade} is now at member level #{memlevel}"
                           end
                           redirect_to user_path(@user)
                        else
                           flash[:error] = "You don't have enough points to purchase this!"
                           redirect_to root_path
                        end
                     else
                        flash[:error] = "You are currently at the max for that upgrade!"
                        redirect_to root_path
                     end
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
