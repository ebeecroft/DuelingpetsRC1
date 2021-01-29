module MonstertypesHelper

   private
      def getMonstertypeParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Monstertype")
            value = params.require(:monstertype).permit(:name, :basecost)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def editCommons(type)
         monstertypeFound =  Monstertype.find_by_id(getMonstertypeParams("Id"))
         if(monstertypeFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == monstertypeFound.user_id) || logged_in.pouch.privilege == "Admin"))
               @monstertype = monstertypeFound
               if(type == "update")
                  if(@monstertype.update_attributes(getMonstertypeParams("Monstertype")))
                     flash[:success] = "Monstertype #{@monstertype.name} was successfully updated."
                     redirect_to @monstertype
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
                  allMonstertypes = Monstertype.order("id desc").page(getMonstertypeParams("Page")).per(10)
                  @monstertypes = allMonstertypes
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  monstertypeFound = Monstertype.find_by_name(getMonstertypeParams("Name"))
                  if(monstertypeFound)
                     @monstertype = monstertypeFound
                     if(type == "update")
                        if(@monstertype.update_attributes(getMonstertypeParams("Monstertype")))
                           flash[:success] = "Monstertype #{@monstertype.name} was successfully updated."
                           redirect_to monstertypes_path
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
