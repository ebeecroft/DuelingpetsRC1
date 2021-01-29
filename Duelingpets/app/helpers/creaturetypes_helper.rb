module CreaturetypesHelper

   private
      def getCreaturetypeParams(type)
         value = ""
         if(type == "User")
            value = params[:id]
         elsif(type == "Creaturetype")
            value = params.require(:creaturetype).permit(:name, :basecost, :dreyterriumcost)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def editCommons(type)
         creaturetypeFound =  Creaturetype.find_by_id(getCreaturetypeParams("User"))
         if(creaturetypeFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == creaturetypeFound.user_id) || logged_in.pouch.privilege == "Admin"))
               @creaturetype = creaturetypeFound
               if(type == "update")
                  if(@creaturetype.update_attributes(getCreaturetypeParams("Creaturetype")))
                     flash[:success] = "Creaturetype #{@creaturetype.name} was successfully updated."
                     redirect_to @creaturetype
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
                  allCreaturetypes = Creaturetype.order("id desc").page(getCreaturetypeParams("Page")).per(10)
                  @creaturetypes = allCreaturetypes
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  creaturetypeFound = Creaturetype.find_by_name(getCreaturetypeParams("Name"))
                  if(creaturetypeFound)
                     @creaturetype = creaturetypeFound
                     if(type == "update")
                        if(@creaturetype.update_attributes(getCreaturetypeParams("Creaturetype")))
                           flash[:success] = "Creaturetype #{@creaturetype.name} was successfully updated."
                           redirect_to creaturetypes_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
