module BookworldsHelper

   private
      def getBookworldParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "BookworldId")
            value = params[:bookworld_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Bookworld")
            value = params.require(:bookworld).permit(:name, :description, :open_world, :privateworld, :price)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def indexCommons
         bookworlds = ""
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userBookworlds = userFound.bookworlds.order("updated_on desc, created_on desc")
               bookworlds = userBookworlds
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allBookworlds = Bookworld.order("updated_on desc, created_on desc")
            bookworlds = allBookworlds
         end
         @bookworlds = Kaminari.paginate_array(bookworlds).page(getBookworldParams("Page")).per(10)
      end

      def optional
         value = getBookworldParams("User")
         return value
      end

      def editCommons(type)
         bookworldFound = Bookworld.find_by_name(getBookworldParams("Id"))
         if(bookworldFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == bookworldFound.user_id) || logged_in.pouch.privilege == "Admin"))
               bookworldFound.updated_on = currentTime
               @bookworld = bookworldFound
               @user = User.find_by_vname(bookworldFound.user.vname)
               if(type == "update")
                  if(@bookworld.update_attributes(getBookworldParams("Bookworld")))
                     flash[:success] = "Bookworld #{@bookworld.name} was successfully updated."
                     redirect_to user_bookworld_path(@bookworld.user, @bookworld)
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
         bookworldFound = Bookworld.find_by_name(getBookworldParams("Id"))
         if(bookworldFound)
            removeTransactions
            if((current_user && ((bookworldFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @bookworld = bookworldFound

               #Come back to this when subsheets is added
               books = bookworldFound.books
               @books = Kaminari.paginate_array(books).page(getBookworldParams("Page")).per(10)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == bookworldFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
                     @bookworld.destroy
                     flash[:success] = "#{@bookworld.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to bookworlds_list_path
                     else
                        redirect_to user_bookworlds_path(bookworldFound.user)
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
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/bookworlds/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getBookworldParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newBookworld = logged_in.bookworlds.new
                        if(type == "create")
                           newBookworld = logged_in.bookworlds.new(getBookworldParams("Bookworld"))
                           newBookworld.created_on = currentTime
                           newBookworld.updated_on = currentTime
                        end

                        @bookworld = newBookworld
                        @user = userFound

                        if(type == "create")
                           bookworldcost = Fieldcost.find_by_name("Bookworld")
                           if(logged_in.pouch.amount - bookworldcost.amount >= 0)
                              if(@bookworld.save)
                                 logged_in.pouch.amount -= bookworldcost.amount
                                 @pouch = logged_in.pouch
                                 @pouch.save
                                 flash[:success] = "#{@bookworld.name} was successfully created."
                                 redirect_to user_bookworld_path(@user, @bookworld)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to create bookworld!"
                              redirect_to root_path
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
                  bookworldMode = Maintenancemode.find_by_id(12)
                  if(allMode.maintenance_on || bookworldMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allBookworlds = Bookworld.order("updated_on desc, created_on desc")
                  @bookworlds = allBookworlds.page(getBookworldParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "increase" || type == "decrease")
               bookworldFound = Bookworld.find_by_id(getBookworldParams("BookworldId"))
               if(bookworldFound)
                  pointchange = 0
                  if(type == "increase")
                     pointchange = bookworldFound.price + 10
                  else
                     pointchange = bookworldFound.price - 10
                  end

                  #Saves the change to books price
                  if(pointchange < 0)
                     flash[:error] = "You can't set points below 0!"
                     redirect_to root_path
                  else
                     #hoard = Dragonhoard.find_by_id(fieldcostFound.dragonhoard_id)
                     #basecost = 400
                     #if(hoard.treasury - basecost > -1)
                         #Decreases the points left in the dragonhoard
                     bookworldFound.price = pointchange
                     @bookworld = bookworldFound
                     @bookworld.save
                           #hoard.treasury -= basecost
                           #@dragonhoard = hoard
                           #@dragonhoard.save
                     flash[:success] = "Bookworld #{bookworld.name} price was successfully increased/decreased!"
                     redirect_to user_bookworld_path(@bookworld.user, @bookworld)
                        #else
                           #flash[:error] = "The Dragonhoard points are insufficient!"
                           #redirect_to root_path
                        #end
                  end
               else
                  render "webcontrols/missingpage"
               end
            end
         end
      end
end
