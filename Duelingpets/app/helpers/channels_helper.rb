module ChannelsHelper

   private
      def getChannelParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ChannelId")
            value = params[:channel_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Channel")
            value = params.require(:channel).permit(:name, :description, :bookgroup_id, :privatechannel,
            :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache, :gviewer_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getMainplaylistMusic(mainplaylist)
         allSubplaylists = mainplaylist.subplaylists.order("updated_on desc", "created_on desc")
         value = nil
         if(allSubplaylists.count > 0)
            subplaylists = allSubplaylists.select{|subplaylist| !subplaylist.privatesubplaylist}
            value = getSubplaylistMusic(subplaylists.first)
         end
         return value
      end

      def musicCommons(type)
         channelFound = Channel.find_by_id(params[:id])
         if(channelFound)
            if(current_user && current_user.id == channelFound.user.id)
               if(channelFound.music_on)
                  channelFound.music_on = false
               else
                  channelFound.music_on = true
               end
               @channel = channelFound
               @channel.save
               redirect_to user_channel_path(@channel.user, @channel)
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userChannels = userFound.channels.order("updated_on desc, created_on desc")
               channelsReviewed = userChannels.select{|channel| (current_user && channel.user_id == current_user.id) || (checkBookgroupStatus(channel))}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allChannels = Channel.order("updated_on desc, created_on desc")
            channelsReviewed = allChannels.select{|channel| (current_user && channel.user_id == current_user.id) || (checkBookgroupStatus(channel))}
         end
         @channels = Kaminari.paginate_array(channelsReviewed).page(getChannelParams("Page")).per(10)
      end

      def optional
         value = getChannelParams("User")
         return value
      end

      def editCommons(type)
         channelFound = Channel.find_by_id(getChannelParams("Id"))
         if(channelFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == channelFound.user_id) || logged_in.pouch.privilege == "Admin"))
               channelFound.updated_on = currentTime
               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               #Allows us to select the user who can view the channel
               gviewers = Gviewer.order("created_on desc")
               @gviewers = gviewers
               @channel = channelFound
               @user = User.find_by_vname(channelFound.user.vname)
               if(type == "update")
                  if(@channel.update_attributes(getChannelParams("Channel")))
                     flash[:success] = "Channel #{@channel.name} was successfully updated."
                     redirect_to user_channel_path(@channel.user, @channel)
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
         channelFound = Channel.find_by_name(getChannelParams("Id"))
         if(channelFound)
            removeTransactions
            if((current_user && ((channelFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || checkBookgroupStatus(channelFound))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @channel = channelFound

               #Come back to this when subsheets is added
               mainplaylists = channelFound.mainplaylists
               @mainplaylists = Kaminari.paginate_array(mainplaylists).page(getChannelParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == channelFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @channel.destroy
                     flash[:success] = "#{@channel.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to channels_list_path
                     else
                        redirect_to user_channels_path(channelFound.user)
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
               channelMode = Maintenancemode.find_by_id(13)
               if(allMode.maintenance_on || channelMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/channels/maintenance"
                     end
                  end
               else
                  indexCommons
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
                  userFound = User.find_by_vname(getChannelParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newChannel = logged_in.channels.new
                        if(type == "create")
                           newChannel = logged_in.channels.new(getChannelParams("Channel"))
                           newChannel.created_on = currentTime
                           newChannel.updated_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        #Allows us to select the user who can view the channel
                        gviewers = Gviewer.order("created_on desc")
                        @gviewers = gviewers

                        @channel = newChannel
                        @user = userFound

                        if(type == "create")
                           channelcost = Fieldcost.find_by_name("Channel")
                           if(logged_in.pouch.amount - channelcost.amount >= 0)
                              if(@channel.save)
                                 logged_in.pouch.amount -= channelcost.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 flash[:success] = "#{@channel.name} was successfully created."
                                 redirect_to user_channel_path(@user, @channel)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create channel!"
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
            elsif(type == "music")
               if(current_user && current_user.pouch.privilege == "Admin")
                  musicCommons(type)
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
                     musicCommons(type)
                  end
               end
            elsif(type == "list")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allChannels = Channel.order("updated_on desc, created_on desc")
                  @channels = allChannels.page(getChannelParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
