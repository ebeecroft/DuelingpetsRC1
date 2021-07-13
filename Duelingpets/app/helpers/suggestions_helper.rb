module SuggestionsHelper

   private
      def getSuggestionParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Suggestion")
            value = params.require(:suggestion).permit(:title, :description)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def economyTransaction(type, points, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Idea"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Suggestion"
         newTransaction.econtype = type
         newTransaction.amount = points
         #Currency can be either Points, Emeralds or Skildons
         newTransaction.currency = currency
         if(type != "Tax")
            newTransaction.user_id = userid
         else
            newTransaction.dragonhoard_id = 1
         end
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def indexCommons
         logged_in = current_user
         if(logged_in)
            allSuggestions = Suggestion.order("updated_on desc, created_on desc")
            suggestions = allSuggestions.select{|suggestion| current_user && (current_user.pouch.privilege == "Admin" || suggestion.user_id == current_user.id)}
            @suggestions = Kaminari.paginate_array(suggestions).page(getSuggestionParams("Page")).per(10)
         else
            redirect_to root_path
         end
      end

      def editCommons(type)
         suggestionFound = Suggestion.find_by_id(getSuggestionParams("Id"))
         if(suggestionFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == suggestionFound.user_id) || logged_in.pouch.privilege == "Admin"))
               suggestionFound.updated_on = currentTime
               @suggestion = suggestionFound
               @user = User.find_by_vname(suggestionFound.user.vname)
               if(type == "update")
                  if(@suggestion.update_attributes(getSuggestionParams("Suggestion")))
                     flash[:success] = "Suggestion #{@suggestion.title} was successfully updated."
                     redirect_to suggestions_path
                  else
                     render "edit"
                  end
               elsif(type == "destroy")
                  cleanup = Fieldcost.find_by_name("Suggestioncleanup")
                  if(suggestionFound.user.pouch.amount - cleanup.amount >= 0)
                     #Removes the content and decrements the owner's pouch
                     suggestionFound.user.pouch.amount -= cleanup.amount
                     @pouch = suggestionFound.user.pouch
                     @pouch.save
                     economyTransaction("Sink", cleanup.amount, suggestionFound.user.id, "Points")
                     flash[:success] = "#{@suggestion.name} was successfully removed."
                     @suggestion.destroy
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to suggestions_path
                     else
                        redirect_to suggestions_path
                        #redirect_to mainplaylist_subplaylist_path(movieFound.subplaylist.mainplaylist, movieFound.subplaylist)
                     end
                  else
                     flash[:error] = "#{@suggestion.user.vname}'s has insufficient points to remove the suggestion!"
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to suggestions_path
                     else
                        redirect_to suggestions_path
                        #redirect_to mainplaylist_subplaylist_path(movieFound.subplaylist.mainplaylist, movieFound.subplaylist)
                     end
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
               userMode = Maintenancemode.find_by_id(13)
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
               userMode = Maintenancemode.find_by_id(13)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/users/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getSuggestionParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newSuggestion = logged_in.suggestions.new
                        if(type == "create")
                           newSuggestion = logged_in.suggestions.new(getSuggestionParams("Suggestion"))
                           newSuggestion.created_on = currentTime
                           newSuggestion.updated_on = currentTime
                        end

                        @suggestion = newSuggestion
                        @user = userFound

                        if(type == "create")
                           if(@suggestion.save)
                              suggestion = Fieldcost.find_by_name("Suggestion")
                              logged_in.pouch.amount += suggestion.amount
                              @pouch = logged_in.pouch
                              @pouch.save
                              economyTransaction("Source", suggestion.amount, newSuggestion.user_id, "Points")
                              ContentMailer.content_created(@suggestion, "Suggestion", suggetion.amount).deliver_now
                              flash[:success] = "Suggestion #{@suggestion.title} was successfully created."
                              redirect_to suggestions_path
                           else
                              render "new"
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
                  userMode = Maintenancemode.find_by_id(13)
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
            end
         end
      end
end
