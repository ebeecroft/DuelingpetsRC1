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
      
      def economyTransaction(type, points, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type == "Sink")
            newTransaction.econattr = "Purchase"
         elsif(type == "Tax")
            newTransaction.econattr = "Treasury"
         elsif(type == "Source")
            newTransaction.econattr = "Fund"
         end
         newTransaction.content_type = "Jukebox"
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
      
      def jukeboxValue(jukeboxFound)
         jukebox = Fieldcost.find_by_name("Jukebox")
         mainsheet = Fieldcost.find_by_name("Mainsheet")   
         subsheet = Fieldcost.find_by_name("Subsheet")
         sound = Fieldcost.find_by_name("Sound")
         allSheets = Subsheet.all
         subsheets = allSheets.select{|subsheet| subsheet.mainsheet.jukebox_id == jukeboxFound.id}
         allSounds = Sound.all
         sounds = allSounds.select{|sound| sound.reviewed && sound.subsheet.mainsheet.jukebox_id == jukeboxFound.id}
         points = (jukebox.amount + (jukeboxFound.mainsheets.count * mainsheet.amount) + (subsheets.count * subsheet.amount) + (sounds.count * sound.amount))
         return points
      end

      def getSoundCounts(mainsheet)
         allSounds = Sound.all
         sounds = allSounds.select{|sound| sound.reviewed && sound.subsheet.mainsheet_id == mainsheet.id}
         return sounds.count
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
               mainsheets = jukeboxFound.mainsheets
               @mainsheets = Kaminari.paginate_array(mainsheets).page(getJukeboxParams("Page")).per(10)
               allSheets = Subsheet.all
               subsheets = allSheets.select{|subsheet| subsheet.mainsheet.jukebox_id == @jukebox.id}
               @subsheets = subsheets.count
               allSounds = Sound.all
               sounds = allSounds.select{|sound| sound.reviewed && sound.subsheet.mainsheet.jukebox_id == @jukebox.id}
               @sounds = sounds.count
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == jukeboxFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     if(jukeboxFound.user.gameinfo.startgame)
                        #Gives the user points back for selling their jukebox
                        points = (jukeboxValue(jukeboxFound) * 0.30).round
                        jukeboxFound.user.pouch.amount += points
                        @pouch = jukeboxFound.user.pouch
                        @pouch.save
                        economyTransaction("Source", points, jukeboxFound.user_id, "Points") #Part of this will be emeralds and points
                        @jukebox.destroy
                        flash[:success] = "#{@jukebox.name} was successfully removed."
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to jukeboxes_list_path
                        else
                           redirect_to user_jukeboxes_path(jukeboxFound.user)
                        end
                     else
                        if(logged_in.pouch.privilege == "Admin")
                           flash[:error] = "The composer has not activated the game yet!"
                           redirect_to jukeboxes_list_path
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
                           price = Fieldcost.find_by_name("Jukebox")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(logged_in.gameinfo.startgame)
                                 if(@jukebox.save)
                                    logged_in.pouch.amount -= price.amount
                                    @pouch = logged_in.pouch
                                    @pouch.save
                                    hoard = Dragonhoard.find_by_id(1)
                                    hoard.profit += tax
                                    @hoard = hoard
                                    @hoard.save
                                    economyTransaction("Sink", price.amount - tax, logged_in.id, "Points")
                                    economyTransaction("Tax", tax, logged_in.id, "Points")
                                    flash[:success] = "#{@jukebox.name} was successfully created."
                                    redirect_to user_jukebox_path(@user, @jukebox)
                                 else
                                    render "new"
                                 end
                              else
                                 flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                                 redirect_to edit_gameinfo_path(logged_in.gameinfo)
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
