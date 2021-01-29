module PouchtypesHelper

   private
      def getPouchtypeParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "PouchtypeId")
            value = params[:pouchtype_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Pouchtype")
            value = params.require(:pouchtype).permit(:name)
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
               removeTransactions
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  allPouchtypes = Pouchtype.order("created_on desc")
                  @pouchtypes = Kaminari.paginate_array(allPouchtypes).page(getPouchtypeParams("Page")).per(10)                           
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  newPouchtype = Pouchtype.new
                  if(type == "create")
                     newPouchtype = Pouchtype.new(getPouchtypeParams("Pouchtype"))
                     newPouchtype.created_on = currentTime
                  end
                  @pouchtype = newPouchtype
                  if(type == "create")
                     if(@pouchtype.save)
                        flash[:success] = "#{@pouchtype.name} was successfully created."
                        redirect_to pouchtypes_path
                     else
                        render "new"
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  pouchtypeFound = Pouchtype.find_by_name(getPouchtypeParams("Name"))
                  if(pouchtypeFound)
                     @pouchtype = pouchtypeFound
                     if(type == "update")
                        if(@pouchtype.update_attributes(getPouchtypeParams("Pouchtype")))
                           flash[:success] = "Pouchtype #{@pouchtype.name} was successfully updated."
                           redirect_to pouchtypes_path
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
