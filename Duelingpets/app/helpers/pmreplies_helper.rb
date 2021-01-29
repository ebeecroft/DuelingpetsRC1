module PmrepliesHelper

   private
      def getPMreplyParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "PMreplyId")
            value = params[:pmreply_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "PMreply")
            value = params.require(:pmreply).permit(:message, :image, :remote_image_url, :image_cache, :ogg, :remote_ogg_url, :ogg_cache,
            :mp3, :remote_mp3_url, :mp3_cache, :ogv, :remote_ogv_url, :ogv_cache, :mp4, :remote_mp4_url, :mp4_cache)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def editCommons(type)
         pmreplyFound = Pm.find_by_id(getPmreplyParams("Id"))
         if(pmreplyFound)
            logged_in = current_user
            if(type == "edit" || type == "update")
               if(logged_in && ((logged_in.id == pmreplyFound.user_id) || logged_in.pouch.privilege == "Admin"))
                  pmreplyFound.updated_on = currentTime
                  @pmreply = pmreplyFound
                  @pm = Pm.find_by_id(pmreplyFound.pm.id)
                  if(type == "update")
                     if(@pmreply.update_attributes(getPmreplyParams("Pmreply")))
                        flash[:success] = "PMreply was successfully updated."
                        redirect_to pmbox_pm_path(@pm.pmbox, @pmreply.pm)
                     else
                        render "edit"
                     end
                  end
               else
                  redirect_to root_path
               end
            else
               if(type == "destroy")
                  if(logged_in && ((logged_in.id == pmreplyFound.user_id) || (logged_in.pouch.privilege == "Admin")))
                     #Eventually consider adding a sink to this
                     @pmreply = pmreplyFound
                     @pm = Pm.find_by_id(pmreplyFound.pm.id)
                     @pmreply.destroy
                     flash[:success] = "PMreply was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to pmreplies_path
                     else
                        redirect_to pmbox_pm_path(@pm.pmbox, @pm)
                     end
                  else
                     redirect_to root_path
                  end
               end
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
            if(type == "index")
               if(current_user && current_user.pouch.privilege == "Admin")
                  removeTransactions
                  allPMreplies = Pmreply.order("created_on desc")
                  @pmreplies = Kaminari.paginate_array(allPMreplies).page(getPmreplyParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/users/maintenance"
                  end
               else
                  logged_in = current_user
                  pmFound = Pm.find_by_id(params[:pm_id])
                  if(logged_in && pmFound)
                     if(logged_in.id == pmFound.user_id || logged_in.id == pmFound.pmbox.user_id)
                        newPmreply = pmFound.pmreplies.new
                        if(type == "create")
                           newPmreply = pmFound.pmreplies.new(getPMreplyParams("PMreply"))
                           newPmreply.created_on = currentTime
                           newPmreply.updated_on = currentTime
                           newPmreply.user_id = logged_in.id
                           pmFound.updated_on = currentTime

                           #Sets the user that receives the pm read status to unread
                           if(newPmreply.user_id == pmFound.user_id)
                              pmFound.user2_unread = true
                           else
                              pmFound.user1_unread = true
                           end
                        end

                        @pmreply = newPmreply
                        @pm = pmFound

                        if(type == "create")
                           pmreplycost = Fieldcost.find_by_name("PMreply")
                           if(logged_in.pouch.amount - pmreplycost.amount >= 0)
                              if(@pmreply.save)
                                 #Ecomony transaction later
                                 logged_in.pouch.amount -= pmreplycost.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 @pm.save

                                 url = "http://www.duelingpets.net/pmboxes/{@pm.pmbox_id}/pms/{@pm.id}"
                                 CommunityMailer.messaging(@pmreply, "PMreply", url).deliver_now
                                 flash[:success] = "PMreply was successfully created."
                                 redirect_to pmbox_pm_path(@pm.pmbox, @pmreply.pm)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to send pmreplies!"
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
            elsif(type == "edit" || type == "update" || type == "destroy")
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
            end
         end
      end
end
