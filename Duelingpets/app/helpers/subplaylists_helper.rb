module SubplaylistsHelper

   private
      def getSubplaylistParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Mainplaylist")
            value = params[:mainplaylist_id]
         elsif(type == "Subplaylist")
            value = params.require(:subplaylist).permit(:title, :description, :collab_mode, :fave_folder, :privatesubsheet)
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
            newTransaction.attribute = "Content"
         else
            newTransaction.attribute = "Treasury"
         end
         newTransaction.content_type = "Subplaylist"
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

      def updateChannel(mainplaylist)
         mainplaylist.updated_on = currentTime
         @mainplaylist = mainplaylist
         @mainplaylist.save
         channel = Channel.find_by_id(@mainplaylist.channel_id)
         channel.updated_on = currentTime
         @channel = channel
         @channel.save
      end

      def editCommons(type)
         subplaylistFound = Subplaylist.find_by_id(getSubplaylistParams("Id"))
         if(subplaylistFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == subplaylistFound.user_id) || logged_in.pouch.privilege == "Admin"))
               subplaylistFound.updated_on = currentTime
               @subplaylist = subplaylistFound
               @mainplaylist = Mainplaylist.find_by_id(subplaylistFound.mainplaylist.id)
               if(type == "update")
                  if(@subplaylist.update_attributes(getSubplaylistParams("Subplaylist")))
                     updateChannel(@mainplaylist)
                     flash[:success] = "Subplaylist #{@subplaylist.title} was successfully updated."
                     redirect_to mainplaylist_subplaylist_path(@subplaylist.mainplaylist, @subplaylist)
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
         subplaylistFound = Subplaylist.find_by_id(getSubplaylistParams("Id"))
         if(subplaylistFound)
            removeTransactions
            if((current_user && ((subplaylistFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (!subplaylistFound.privatesubplaylist? && checkBookgroupStatus(subplaylistFound.mainplaylist.channel)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @subplaylist = subplaylistFound
               movies = subplaylistFound.movies
               @movies = Kaminari.paginate_array(movies).page(getSubplaylistParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == subplaylistFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Subplaylistcleanup")
                     if(subplaylistFound.user.pouch.amount - cleanup.amount >= 0)
                        #Removes the content and decrements the owner's pouch
                        subplaylistFound.user.pouch.amount -= cleanup.amount
                        @pouch = subplaylistFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup.amount, subplaylistFound.user.id, "Points")
                        flash[:success] = "#{@subplaylist.title} was successfully removed."
                        @subplaylist.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to subplaylists_path
                        else
                           redirect_to channel_mainplaylist_path(subplaylistFound.mainplaylist.channel, subplaylist.mainplaylist)
                        end
                     else
                        flash[:error] = "#{@subplaylist.user.vname}'s has insufficient points to remove the subplaylist!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to subplaylists_path
                        else
                           redirect_to channel_mainplaylist_path(subplaylistFound.mainplaylist.channel, subplaylist.mainplaylist)
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
                  allSubplaylists = Subplaylist.order("updated_on desc, created_on desc")
                  @subplaylists = Kaminari.paginate_array(allSubplaylists).page(getSubplaylistParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               channelMode = Maintenancemode.find_by_id(13)
               if(allMode.maintenance_on || channelMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/channels/maintenance"
                  end
               else
                  logged_in = current_user
                  mainplaylistFound = Mainplaylist.find_by_id(getSubplaylistParams("Mainplaylist"))
                  if(logged_in && mainplaylistFound)
                     if(logged_in.id == mainplaylistFound.user_id)
                        newSubplaylist = mainplaylistFound.subplaylists.new
                        if(type == "create")
                           newSubplaylist = mainplaylistFound.subplaylists.new(getSubplaylistParams("Subplaylist"))
                           newSubplaylist.created_on = currentTime
                           newSubplaylist.updated_on = currentTime
                           newSubplaylist.user_id = logged_in.id
                        end

                        @subplaylist = newSubplaylist
                        @mainplaylist = mainplaylistFound

                        if(type == "create")
                           price = Fieldcost.find_by_name("Subplaylist")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(logged_in.pouch.amount - price.amount >= 0)
                              if(@subplaylist.save)
                                 logged_in.pouch.amount -= price.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 hoard = Dragonhoard.find_by_id(1)
                                 hoard.profit += tax
                                 @hoard = hoard
                                 @hoard.save
                                 economyTransaction("Sink", price.amount - tax, subplaylistFound.user.id, "Points")
                                 economyTransaction("Tax", tax, subplaylistFound.user.id, "Points")
                                 updateChannel(@subplaylist.mainplaylist)
                                 flash[:success] = "#{@subplaylist.title} was successfully created."
                                 redirect_to mainplaylist_subplaylist_path(@mainplaylist, @subplaylist)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create a subplaylist!"
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
                  channelMode = Maintenancemode.find_by_id(13)
                  if(allMode.maintenance_on || channelMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/channels/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               channelMode = Maintenancemode.find_by_id(13)
               if(allMode.maintenance_on || channelMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/channels/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            end
         end
      end
end
