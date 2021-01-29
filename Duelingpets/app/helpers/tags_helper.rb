module TagsHelper

   private
      def getTagParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "TagId")
            value = params[:tag_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Tag")
            value = params.require(:tag).permit(:name, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userTags = userFound.tags.order("updated_on desc, created_on desc")
               tagsReviewed = userTags.select{|tag| (current_user && tag.user_id == current_user.id) || (checkBookgroupStatus(tag))}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allTags = Tag.order("updated_on desc, created_on desc")
            tagsReviewed = allTags.select{|tag| (current_user && tag.user_id == current_user.id) || (checkBookgroupStatus(tag))}
         end
         @tags = Kaminari.paginate_array(tagsReviewed).page(getTagParams("Page")).per(10)
      end

      def optional
         value = getTagParams("User")
         return value
      end

      def editCommons(type)
         tagFound = Tag.find_by_id(getTagParams("Id"))
         if(tagFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == tagFound.user_id) || logged_in.pouch.privilege == "Admin"))
               if(type == "edit" || type == "update")
                  tagFound.updated_on = currentTime
                  #Determines the type of bookgroup the user belongs to
                  allGroups = Bookgroup.order("created_on desc")
                  allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                  @group = allowedGroups
               end
               @tag = tagFound
               @user = User.find_by_vname(tagFound.user.vname)
               if(type == "update")
                  if(@tag.update_attributes(getTagParams("Tag")))
                     flash[:success] = "Tag #{@tag.name} was successfully updated."
                     redirect_to user_tags_path(@tag.user)
                  else
                     render "edit"
                  end
               elsif(type == "destroy")
                  #Eventually consider adding a sink to this
                  @tag.destroy
                  flash[:success] = "#{tagFound.name} was successfully removed."
                  if(logged_in.pouch.privilege == "Admin")
                        redirect_to tags_list_path
                  else
                     redirect_to user_tags_path(tagFound.user)
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
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  end
               else
                  indexCommons
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
                  userFound = User.find_by_vname(getTagParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newTag = logged_in.tags.new
                        if(type == "create")
                           newTag = logged_in.tags.new(getTagParams("Tag"))
                           newTag.created_on = currentTime
                           newTag.updated_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        @tag = newTag
                        @user = userFound

                        if(type == "create")
                           tagcost = Fieldcost.find_by_name("Tag")
                           if(logged_in.pouch.amount - tagcost.amount >= 0)
                              if(@tag.save)
                                 logged_in.pouch.amount -= tagcost.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 flash[:success] = "#{@tag.name} was successfully created."
                                 redirect_to user_tags_path(@user)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create tag!"
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
            elsif(type == "list")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allTags = Tag.order("updated_on desc, created_on desc")
                  @tags = allTags.page(getTagParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
