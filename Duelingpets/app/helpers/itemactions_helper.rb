module ItemactionsHelper

   private
      def getItemactionParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Itemaction")
            value = params.require(:itemaction).permit(:name)
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
            if(current_user && current_user.pouch.privilege == "Admin")
               if(type == "index")
                  allActions = Itemaction.order("created_on desc")
                  @itemactions = Kaminari.paginate_array(allActions).page(getItemactionParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  newAction = Itemaction.new
                  if(type == "create")
                     newAction = Itemaction.new(getItemactionParams("Itemaction"))
                     newAction.created_on = currentTime
                  end
                  @itemaction = newAction
                  if(type == "create")
                     if(@itemaction.save)
                        flash[:success] = "#{@itemaction.name} action was successfully created."
                        redirect_to itemactions_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update" || type == "destroy")
                  actionFound = Itemaction.find_by_name(getItemactionParams("Id"))
                  if(actionFound)
                     @itemaction = actionFound
                     if(type == "update")
                        if(@itemaction.update_attributes(getItemactionParams("Itemaction")))
                           flash[:success] = "#{@itemaction.name} action was successfully updated."
                           redirect_to itemactions_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        @itemaction.destroy
                        flash[:success] = "#{actionFound.name} action was succesfully removed."
                        redirect_to itemactions_path
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               end
            else
               redirect_to root_path
            end
         end
      end
end
