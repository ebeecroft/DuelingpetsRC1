module PouchesHelper

   private
      def getPouchParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Pouch")
            value = params.require(:pouch).permit(:privilege)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
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
                  allPouches = Pouch.order("signed_in_at desc")
                  @pouches = Kaminari.paginate_array(allPouches).page(getPouchParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               pouchFound = Pouch.find_by_id(getPouchParams("Id"))
               if(pouchFound)
                  logged_in = current_user
                  if(logged_in && logged_in.pouch.privilege == "Admin")
                     @pouch = pouchFound
                     if(type == "update")
                        if(@pouch.update(getPouchParams("Pouch")))
                           flash[:success] = "#{@pouch.user.vname} privilege was successfully updated."
                           redirect_to pouches_path
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
            else
               redirect_to root_path
            end
         end
      end
end
