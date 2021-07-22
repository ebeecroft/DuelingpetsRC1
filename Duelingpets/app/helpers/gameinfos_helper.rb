module GameinfosHelper

   private
      def getInfoParams(type)
         value = ""
         if(type == "User")
            value = params[:id]
         elsif(type == "Gameinfo")
            value = params.require(:gameinfo).permit(:difficulty_id, :lives_enabled, :ageing_enabled,
            :startgame)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def editCommons(type)
         infoFound =  Gameinfo.find_by_id(getInfoParams("User"))
         if(infoFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == infoFound.user_id) || logged_in.pouch.privilege == "Admin"))
               if(!infoFound.startgame)
                  difficulties = Difficulty.order("created_on desc")
                  @difficulties = difficulties
                  @gameinfo = infoFound
                  if(type == "update")
                     if(@gameinfo.startgame)
                        infoFound.activated_on = currentTime
                     end
                     if(@gameinfo.update_attributes(getInfoParams("Gameinfo")))
                        if(@gameinfo.startgame)
                           pouch = Pouch.find_by_user_id(@gameinfo.user.id)
                           difficulty = Difficulty.find_by_id(@gameinfo.difficulty_id)
                           if(!difficulty.gainpoints)
                              pouch.amount -= difficulty.pointdebt
                           else
                              pouch.amount += difficulty.pointdebt
                           end
                           @pouch = pouch
                           @pouch.save
                        end
                        flash[:success] = "Gameinfo for #{@gameinfo.user.vname} was successfully updated."
                        redirect_to user_path(@gameinfo.user)
                     else
                        render "edit"
                     end
                  end
               else
                  flash[:error] = "The game has already been started, difficulty can't be changed!"
                  redirect_to user_path(infoFound.user)
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
                  allInfos = Gameinfo.order("id desc")
                  @gameinfos = Kaminari.paginate_array(allInfos).page(getInfoParams("Page")).per(10)
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
