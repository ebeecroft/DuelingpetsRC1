module DifficultiesHelper

   private
      def getDifficultyParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Difficulty")
            value = params.require(:difficulty).permit(:name, :pointdebt, :pointloan, :emeralddebt, :emeraldloan)
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
                  removeTransactions
                  allDifficulties = Difficulty.order("created_on desc")
                  @difficulties = Kaminari.paginate_array(allDifficultiess).page(getDifficultyParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  newDomain = Difficulty.new
                  if(type == "create")
                     newDifficulty = Difficulty.new(getDomainParams("Difficulty"))
                     newDifficulty.created_on = currentTime
                  end
                  @difficulty = newDifficulty
                  if(type == "create")
                     if(@difficulty.save)
                        flash[:success] = "The difficulty #{@difficulty.name} has been created!"
                        redirect_to difficulties_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update" || type == "destroy")
                  difficultyFound = Difficulty.find_by_id(getDifficultyParams("Id"))
                  if(difficultyFound)
                     @difficulty = difficultyFound
                     if(type == "update")
                        if(@difficulty.update_attributes(getDifficultyParams("Difficulty")))
                           flash[:success] = "The difficulty #{@difficulty.name} was successfully updated."
                           redirect_to difficulties_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        flash[:success] = "Difficulty #{@difficulty.name} was successfully removed."
                        @difficulty.destroy
                        redirect_to difficulties_path
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
