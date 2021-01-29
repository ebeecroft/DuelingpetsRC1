module ItemtypesHelper

   private
      def getItemtypeParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ItemtypeId")
            value = params[:itemtype_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Itemtype")
            value = params.require(:itemtype).permit(:name, :basecost, :dreyterriumcost)
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
                  allItemtypes = Itemtype.order("created_on desc")
                  @itemtypes = Kaminari.paginate_array(allItemtypes).page(getItemtypeParams("Page")).per(10)                           
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  newItemtype = Itemtype.new
                  if(type == "create")
                     newItemtype = Itemtype.new(getItemtypeParams("Itemtype"))
                     newItemtype.created_on = currentTime
                  end
                  @itemtype = newItemtype
                  if(type == "create")
                     if(@itemtype.save)
                        flash[:success] = "#{@itemtype.name} was successfully created."
                        redirect_to itemtypes_path
                     else
                        render "new"
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  itemtypeFound = Itemtype.find_by_name(getItemtypeParams("Name"))
                  if(itemtypeFound)
                     @itemtype = itemtypeFound
                     if(type == "update")
                        if(@itemtype.update_attributes(getItemtypeParams("Itemtype")))
                           flash[:success] = "Itemtype #{@itemtype.name} was successfully updated."
                           redirect_to itemtypes_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        flash[:success] = "#{@itemtype.name} was successfully removed."
                        @itemtype.destroy
                        redirect_to itemtypes_path
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
