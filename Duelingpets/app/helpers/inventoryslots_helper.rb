module InventoryslotsHelper

   private
      def getInventoryslotParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "InventoryId")
            value = params[:inventory_id]
         elsif(type == "Inventoryslot")
            value = params.require(:inventoryslot).permit(:name, :inventory_id)
         elsif(type == "ItemId")
            value = params[:inventoryslot][:item_id]
         elsif(type == "SlotId")
            value = params[:inventoryslot][:inventoryslot_id]
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
            newTransaction.econattr = "Purchase"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Inventory"
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

      def editCommons(type)
         slotFound = Inventoryslot.find_by_id(getInventoryslotParams("Id"))
         if(slotFound)
            logged_in = current_user
            if(logged_in && ((logged_in.inventory.id == slotFound.inventory_id) || logged_in.pouch.privilege == "Admin"))
               @inventoryslot = slotFound
               @inventory = Inventory.find_by_id(slotFound.inventory.id)
               if(type == "update")
                  if(@inventoryslot.update_attributes(getInventoryslotParams("Inventoryslot")))
                     flash[:success] = "Inventoryslot #{@inventoryslot.name} was successfully updated."
                     redirect_to user_inventory_path(@inventory.user, @inventory)
                  else
                     render "edit"
                  end
               elsif(type == "destroy")
                  if(checkSlot(slotFound))
                     #Removes the inventory and decrements the owner's pouch
                     price = Fieldcost.find_by_name("Inventoryslotcleanup")
                     if(slotFound.user.pouch.amount - price.amount >= 0)
                        slotFound.user.pouch.amount -= price.amount
                        @pouch = slotFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", price.amount, slotFound.inventory.user.id, "Points")
                        @inventoryslot.destroy
                        flash[:success] = "Inventory slot #{slotFound.name} was successfully removed."
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to inventoryslots_path
                        else
                           redirect_to user_inventory_path(@inventory.user, @inventory)
                        end
                     else
                        flash[:error] = "#{@inventoryslot.inventory.user.vname}'s has insufficient points to remove the inventoryslot!"
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "Slot #{slotFound.name} has items and can't be removed!"
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
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  allInvs = Inventoryslot.all
                  @inventoryslots = Kaminari.paginate_array(allInvs).page(getInventoryslotParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(9)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/items/maintenance"
                  end
               else
                  logged_in = current_user
                  inventoryFound = Inventory.find_by_id(getInventoryslotParams("InventoryId"))
                  if((logged_in && inventoryFound) && (logged_in.id == inventoryFound.user_id))
                     newSlot = inventoryFound.inventoryslots.new
                     if(type == "create")
                        newSlot = inventoryFound.inventoryslots.new(getInventoryslotParams("Inventoryslot"))
                     end
                     @inventory = inventoryFound
                     @inventoryslot = newSlot
                     if(type == "create")
                        price = Fieldcost.find_by_name("Inventoryslot")
                        rate = Ratecost.find_by_name("Purchaserate")
                        tax = (price.amount * rate.amount).round
                        if(logged_in.pouch.amount - price.amount >= 0)
                           if(@inventoryslot.save)
                              logged_in.pouch.amount -= price.amount
                              @pouch = logged_in.pouch
                              @pouch.save
                              hoard = Dragonhoard.find_by_id(1)
                              hoard.profit += tax
                              @hoard = hoard
                              @hoard.save
                              economyTransaction("Sink", price.amount - tax, inventoryFound.user.id, "Points")
                              economyTransaction("Tax", tax, inventoryFound.user.id, "Points")
                              flash[:success] = "#{@inventoryslot.name} was successfully created."
                              redirect_to user_inventory_path(@inventory.user, @inventory)
                           else
                              render "new"
                           end
                        else
                           flash[:error] = "Insufficient funds to create an inventoryslot!"
                           redirect_to user_path(logged_in.id)
                        end
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
                  itemMode = Maintenancemode.find_by_id(9)
                  if(allMode.maintenance_on || itemMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "purchase")
               logged_in = current_user
               itemFound = Item.find_by_id(getInventoryslotParams("ItemId"))
               slotFound = Inventoryslot.find_by_id(getInventoryslotParams("SlotId"))
               if(logged_in && itemFound && slotFound && slotFound.inventory_id == logged_in.inventory.id)
                  #Store item only if there is space
                  noRoom = storeitem(slotFound, itemFound)
                  if(!noRoom)
                     affordItem = ((logged_in.pouch.amount - itemFound.cost >= 0) && (logged_in.pouch.emeraldamount - itemFound.emeraldcost >= 0))
                     if(affordItem)
                        #Purchases the item
                        logged_in.pouch.amount -= itemFound.cost
                        logged_in.pouch.emeraldamount -= itemFound.emeraldcost
                        @pouch = logged_in.pouch
                        @pouch.save

                        #Eventually make sure that owners get points later on sells!

                        #Saves the item
                        @inventoryslot = slotFound
                        @inventoryslot.save
                        flash[:success] = "Item #{itemFound.name} was added to the inventory!"
                        redirect_to user_inventory_path(@inventoryslot.inventory.user, @inventoryslot.inventory)
                     else
                        flash[:error] = "Insufficient funds to purchase a #{itemFound.name}!"
                        redirect_to user_path(logged_in.id)
                     end
                  else
                     flash[:error] = "No room to store #{itemFound.name}!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
