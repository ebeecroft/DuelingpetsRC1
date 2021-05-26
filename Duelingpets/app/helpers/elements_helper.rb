module ElementsHelper

   private
      def getElementParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ElementId")
            value = params[:element_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Element")
            value = params.require(:element).permit(:name, :description, :itemart, :remote_itemart_url, :itemart_cache)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, userid)
         #Adds the chapter points to the economy
         newTransaction = Economy.new(params[:economy])
         newTransaction.econtype = "Content"
         newTransaction.content_type = "Element"
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def getChartData(element, type)
         chart = Elementchart.find_by_element_id(element)
         element = ""
         if(type == "Mainweak")
            element = Element.find_by_id(chart.sweak_id)
         elsif(type == "Mildweak")
            element = Element.find_by_id(chart.eweak_id)
         elsif(type == "Strong")
            element = Element.find_by_id(chart.sstrength_id)
         elsif(type == "Mild")
            element = Element.find_by_id(chart.estrength_id)
         end
         return element.name
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userElements = userFound.elements.order("reviewed_on desc, created_on desc")
               elementsReviewed = userElements.select{|element| (current_user && element.user_id == current_user.id) || element.reviewed}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allElements = Element.order("reviewed_on desc, created_on desc")
            elementsReviewed = allElements.select{|element| (current_user && element.user_id == current_user.id) || element.reviewed}
         end
         @elements = Kaminari.paginate_array(elementsReviewed).page(getElementParams("Page")).per(10)
      end

      def optional
         value = getElementParams("User")
         return value
      end

      def editCommons(type)
         elementFound = Element.find_by_name(getElementParams("Id"))
         if(elementFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == elementFound.user_id) || logged_in.pouch.privilege == "Admin"))
               elementFound.updated_on = currentTime
               elementFound.reviewed = false
               @element = elementFound
               @user = User.find_by_vname(elementFound.user.vname)
               if(type == "update")
                  #Update element stats should only happen if not reviewed
                  if(@element.update_attributes(getElementParams("Element")))
                     flash[:success] = "Element #{@element.name} was successfully updated."
                     redirect_to user_element_path(@element.user, @element)
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

      def showCommons(type)
         elementFound = Element.find_by_name(getElementParams("Id"))
         if(elementFound)
            removeTransactions
            if(elementFound.reviewed || current_user && ((elementFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @element = elementFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == elementFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Removes the content and decrements the owner's pouch
                     element = Fieldcost.find_by_name("Element")
                     if(elementFound.user.pouch.amount - element.amount >= 0)
                        elementFound.user.pouch.amount -= element.amount #Remember to come back later to change to emeralds
                        @pouch = elementFound.user.pouch
                        @pouch.save
                        economyTransaction("Tax", price, elementFound.user.id)
                        @element.destroy
                        flash[:success] = "#{@element.name} was successfully removed."
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to elements_list_path
                        else
                           redirect_to user_elements_path(elementFound.user)
                        end
                     else
                        flash[:error] = "Owner has insufficient points to remove the element!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
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
               elementMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || elementMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/elements/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               elementMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || elementMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/elements/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getElementParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newElement = logged_in.elements.new
                        if(type == "create")
                           newElement = logged_in.elements.new(getElementParams("Element"))
                           newElement.created_on = currentTime
                           newElement.updated_on = currentTime
                        end
                        @element = newElement
                        @user = userFound
                        if(type == "create")
                           if(@element.save)
                              newChart = Elementchart.new(params[:elementchart])
                              newChart.element_id = @element.id
                              newChart.sstrength_id = 1
                              newChart.estrength_id = 1
                              newChart.sweak_id = 1
                              newChart.eweak_id = 1
                              @chart = newChart
                              @chart.save
                              url = "http://www.duelingpets.net/elements/review"
                              ContentMailer.content_review(@element, "Element", url).deliver_now
                              flash[:success] = "#{@element.name} was successfully created."
                              redirect_to user_element_path(@user, @element)
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
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  elementMode = Maintenancemode.find_by_id(10)
                  if(allMode.maintenance_on || elementMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/elements/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               elementMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || elementMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/elements/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allElements = Element.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        elementsToReview = allElements.select{|element| !element.reviewed}
                        @elements = Kaminari.paginate_array(elementsToReview).page(getElementParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @elements = allElements.page(getElementParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  elementFound = Element.find_by_id(getElementParams("ElementId"))
                  if(elementFound)
                     pouchFound = Pouch.find_by_user_id(elementFound.user.id)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           elementFound.reviewed = true
                           elementFound.reviewed_on = currentTime
                           element = Fieldcost.find_by_name("Element")
                           if(pouch.amount - element.amount >= 0)
                              @element = elementFound
                              @element.save
                              pouch.amount -= element.amount #Need to change to emeralds later
                              @pouch = pouch
                              @pouch.save
                              economyTransaction("Sink", element.amount, elementFound.user.id)
                              ContentMailer.content_approved(@element, "Element", element.amount).deliver_now
                              flash[:success] = "#{@element.user.vname}'s element #{@element.name} was approved."
                              redirect_to elements_review_path
                           else
                              flash[:error] = "Owner has insufficient funds to create an element!"
                              redirect_to elements_review_path
                           end
                        else
                           @element = elementFound
                           ContentMailer.content_denied(@element, "Element").deliver_now
                           flash[:success] = "#{@element.user.vname}'s element #{@element.name} was denied."
                           redirect_to elements_review_path
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
end
