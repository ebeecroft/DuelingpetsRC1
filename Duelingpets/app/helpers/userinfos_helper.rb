module UserinfosHelper

   private
      def getInfoParams(type)
         value = ""
         if(type == "User")
            value = params[:id]
         elsif(type == "Userinfo")
            value = params.require(:userinfo).permit(:avatar, :remote_avatar_url, :avatar_cache, :miniavatar,
            :remote_miniavatar_url, :miniavatar_cache, :ogg, :remote_ogg_url, :ogg_cache, :info, :daycolor_id, :nightcolor_id, :bookgroup_id, :audiobrowser, :videobrowser, :nightvision, :militarytime)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def editCommons(type)
         infoFound =  Userinfo.find_by_id(getInfoParams("User"))
         if(infoFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == infoFound.user_id) || logged_in.pouch.privilege == "Admin"))
               @userinfo = infoFound
               #Set up different colors for night and day selections
               allColors = Colorscheme.all
               activatedColors = allColors.select{|colorscheme| colorscheme.activated || ((colorscheme.user_id == logged_in.id) || logged_in.privilege == "Admin")}
               nightcolors = activatedColors.select{|colorscheme| colorscheme.nightcolor == true}
               daycolors = activatedColors.select{|colorscheme| colorscheme.nightcolor == false}
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               @nightcolors = nightcolors
               @daycolors = daycolors
               if(type == "update")
                  if(@userinfo.update_attributes(getInfoParams("Userinfo")))
                     flash[:success] = "Userinfo for #{@userinfo.user.vname} was successfully updated."
                     redirect_to @userinfo.user
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
                  allInfos = Userinfo.order("id desc").page(getInfoParams("Page")).per(10)
                  @userinfos = allInfos
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
                        #the render section
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
