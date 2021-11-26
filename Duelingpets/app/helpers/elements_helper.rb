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
      
      def indexpage
         #Displays the users array of elemets
         if(getElementParams("User"))
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
      
      def showpage
         elementFound = Element.find_by_name(getElementParams("Id"))
         if(elementFound && (elementFound.reviewed || current_user && ((elementFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin")))
            removeTransactions
            #visitTimer(type, blogFound)
            #cleanupOldVisits
            @element = elementFound
         else
            if(!elementFound)
               flash[:error] = "Element doesn't exist!"
            elsif(!elementFound.reviewed)
               flash[:error] = "Element is not accessible to guests!"
            else
               flash[:error] = "User doesn't have permission to view this element!"
            end
            redirect_to root_path
         end
      end
      
      def getElementName(element_id)
         value = Element.find_by_element_id(element_id)
         return value.name
      end
      
      def callMaintenance(type)
         #removeTransactions
         allMode = Maintenancemode.find_by_id(1)
         elementMode = Maintenancemode.find_by_id(10)
         if(allMode.maintenance_on || elementMode.maintenance_on)
            if(current_user && current_user.pouch.privilege == "Admin")
               if(type == "index")
                  indexpage
               elsif(type == "show")
                  showpage
               else
                  editCommons(type)
               end
            else
               if(allMode.maintenance_on)
                  render "/start/maintenance"
               else
                  render "/elements/maintenance"
               end
            end
         else
            if(type == "index")
               indexpage
            elsif(type == "show")
               showpage
            elsif(type == "new" || type == "create")
               createCommons(type)
            else
               editCommons(type)
            end
         end
      end
      
      def createCommons(type)
         logged_in = current_user
         userFound = User.find_by_vname(getElementParams("User"))
         validCreator = (logged_in && userFound && logged_in.id == userFound.id)
         if(validCreator)
            price = Fieldcost.find_by_name("Element")
            
            #Create the element if the user can afford the buildprice
            if(logged_in.gameinfo.startgame && logged_in.pouch.amount - price.amount >= 0)
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
                     url = "http://www.duelingpets.net/elements/review"
                     ContentMailer.content_review(@element, "Element", url).deliver_now
                     flash[:success] = "#{@element.name} was successfully created."
                     redirect_to user_element_path(@user, @element)
                  else
                     render "new"
                  end
               end
            else
               if(!logged_in.gameinfo.startgame)
                  flash[:error] = "{logged_in.vname} has not activated their game yet!"
               else
                  flash[:error] = "#{logged_in.vname} can't afford the element buildprice!"
               end
               redirect_to root_path
            end
         else
            flash[:error] = "The information you entered was invalid!"
            redirect_to root_path
         end
      end
      
      def editCommons(type)
         logged_in = current_user
         elementFound = Element.find_by_name(getElementParams("Id"))
         staff = (logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Reviewer"))
         if(elementFound && logged_in && (staff || logged_in.id == elementFound.user_id))
            elementFound.updated_on = currentTime
            elementFound.reviewed = false
            @element = elementFound
            @user = User.find_by_vname(elementFound.user.vname)
            if(type == "update")
               if(@element.update_attributes(getElementParams("Element")))
                  flash[:success] = "Element #{@element.name} was successfully updated."
                  redirect_to user_element_path(@element.user, @element)
               else
                  render "edit"
               end
            elsif(type == "destroy")
               price = Fieldcost.find_by_name("Element")
               if(staff || (elementFound.user.gameinfo.startgame && elementFound.user.pouch.amount - price.amount >= 0))
                  if(!staff)
                     elementFound.user.pouch.amount -= price.amount #Remember to come back later to change to emeralds
                     @pouch = elementFound.user.pouch
                     @pouch.save
                     economyTransaction("Sink", price.amount, elementFound.user.id, "Points")
                  end
                  @element.destroy
                  flash[:success] = "#{@element.name} was successfully removed."
                  if(logged_in.pouch.privilege == "Admin")
                     redirect_to elements_list_path
                  else
                     redirect_to user_elements_path(elementFound.user)
                  end
               else
                  if(!elementFound.user.gameinfo.startgame)
                     flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                  else
                     flash[:error] = "#{@element.user.vname}'s has insufficient points to remove the element!"
                  end
                  redirect_to root_path
               end
            end
         else
            if(!elementFound)
               flash[:error] = "The element does not exist!"
            else
               flash[:error] = "User doesn't have permission to edit this element!"
            end
            redirect_to root_path
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               #Guest Accessible
               callMaintenance(type)
            elsif(type == "new" || type == "create" || type == "edit" || type == "update" || type == "destroy")
               #Login only
               callMaintenance(type)
            elsif(type == "show")
               #Guest Accessible
               callMaintenance(type)
            elsif(type == "list" || type == "review" || type == "approve" || type == "deny")
               #Staff only
               staff = (current_user && (current_user.pouch.privilege == "Admin" || current_user.pouch.privilege == "Keymaster" || current_user.pouch.privilege == "Reviewer"))
               if(staff)
                  if(type == "review")
                     allElements = Element.order("reviewed_on desc, created_on desc")
                     elementsToReview = allElements.select{|element| !element.reviewed}
                     @elements = Kaminari.paginate_array(elementsToReview).page(getElementParams("Page")).per(10)
                  elsif(type == "list")
                     if(current_user.pouch.privilege == "Admin")
                        allElements = Element.order("reviewed_on desc, created_on desc")
                        @elements = allElements.page(getElementParams("Page")).per(10)
                     else
                        flash[:error] = "Staff doesn't have permission to access this page!"
                        redirect_to root_path
                     end
                  else
                     elementFound = Element.find_by_id(getElementParams("ElementId"))
                     if(elementFound && type == "approve")
                        if(elementFound.buildpaid)
                           elementFound.reviewed = true
                           elementFound.reviewed_on = currentTime
                           @element = elementFound
                           @element.save
                           ContentMailer.content_approved(@element, "Element", 0).deliver_now
                           flash[:success] = "#{@element.user.vname}'s element #{@element.name} was approved."
                           redirect_to elements_review_path
                        else
                           elementFound.buildpaid = true
                           price = Fieldcost.find_by_name("Element")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount)
                           if(elementFound.user.gameinfo.startgame && elementFound.user.pouch.amount - price.amount >= 0)
                              elementFound.reviewed = true
                              elementFound.reviewed_on = currentTime
                              @element = elementFound
                              @element.save
                              
                              #Decrement players emeralds/points from the buildprice
                              elementFound.user.pouch.amount -= price.amount #Need to change to emeralds later
                              @pouch = elementFound.user.pouch
                              @pouch.save
                              
                              #Adds points/emeralds to the centralbank
                              hoard = Dragonhoard.find_by_id(1)
                              hoard.profit += tax
                              @hoard = hoard
                              @hoard.save
                              
                              #Displays the results of the transaction
                              economyTransaction("Sink", price.amount - tax, elementFound.user.id, "Points")
                              economyTransaction("Tax", tax, elementFound.user.id, "Points")
                              ContentMailer.content_approved(@element, "Element", element.amount).deliver_now
                              flash[:success] = "#{@element.user.vname}'s element #{@element.name} was approved."
                              redirect_to elements_review_path
                           else
                              if(!elementFound.user.gameinfo.startgame)
                                 flash[:error] = "{elementFound.user.vname} has not activated their game yet!"
                              else
                                 flash[:error] = "#{elementFound.user.vname} can't afford the element buildprice!"
                              end
                           end
                           redirect_to elements_review_path
                        end
                     elsif(elementFound && type == "deny")
                        @element = elementFound
                        ContentMailer.content_denied(@element, "Element").deliver_now
                        flash[:success] = "#{@element.user.vname}'s element #{@element.name} was denied."
                        redirect_to elements_review_path
                     else
                        flash[:error] = "Element does not exist!"
                        redirect_to root_path
                     end
                  end
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            end
         end
      end
end
