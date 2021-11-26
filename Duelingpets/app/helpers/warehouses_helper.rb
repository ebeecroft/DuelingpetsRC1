module WarehousesHelper

   private
      def getWarehouseParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "WarehouseId")
            value = params[:warehouse_id]
         elsif(type == "Warehouse")
            value = params.require(:warehouse).permit(:name, :message, :store_open)
         elsif(type == "SlotId")
            value = params[:inventoryslot][:inventoryslot_id]
         elsif(type == "WshelfId")
            value = params[:inventoryslot][:witemshelf_id]
         elsif(type == "Slotindex")
            value = params[:inventoryslot][:slotindex_id]
         elsif(type == "Petindex")            
            value = params[:partner][:petindex_id]
         elsif(type == "WdenId")
            value = params[:partner][:wpetden_id]
         elsif(type == "Partnername")
            value = params[:partner][:name]
         elsif(type == "Partnerdescription")
            value = params[:partner][:description]
         elsif(type == "Partner")
            value = params.require(:partner).permit(:name, :description, :creature_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, contentType, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Purchase"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = contentType
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
         warehouseFound = Warehouse.find_by_name(getWarehouseParams("Id"))
         if(warehouseFound)
            logged_in = current_user
            if(logged_in && logged_in.pouch.privilege == "Glitchy")
               @warehouse = warehouseFound
               if(type == "update")
                  if(@warehouse.update_attributes(getWarehousefParams("Warehouse")))
                     flash[:success] = "Warehouse #{@warehouse.name} was successfully updated."
                     redirect_to warehouse_path(@warehouse.name)
                  else
                     render "edit"
                  end
               end
            else
               redirect_to root_path
            end
         else
            redirect_to root_path
         end
      end
            
      def showCommons(type)
         warehouseFound = Warehouse.find_by_name(getWarehouseParams("Id"))
         logged_in = current_user
         if(warehouseFound && logged_in)
            removeTransactions
            @warehouse = warehouseFound
            pets = warehouseFound.wpetdens.all
            @wpetdens = Kaminari.paginate_array(pets).page(getWarehouseParams("Page")).per(1)
            myslots = logged_in.inventory.inventoryslots.all
            @slots = myslots
            shelves = warehouseFound.witemshelves.all
            @witemshelves = Kaminari.paginate_array(shelves).page(getWarehouseParams("Page")).per(1)
         else
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
               removeTransactions
               if(current_user && current_user.pouch.privilege == "Glitchy")
                  allWarehouses = Warehouse.order("updated_on desc, created_on desc")
                  @warehouses = Kaminari.paginate_array(allWarehouses).page(getWarehouseParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               warehouseFound = Warehouse.find_by_name(getWarehouseParams("Id"))
               if(warehouseFound)
                  logged_in = current_user
                  if(logged_in && logged_in.pouch.privilege == "Glitchy")
                     warehouseFound.updated_on = currentTime
                     @warehouse = warehouseFound
                     if(type == "update")
                        if(@warehouse.update_attributes(getWarehouseParams("Warehouse")))
                           flash[:success] = "Warehouse #{@warehouse.name} was successfully updated."
                           redirect_to warehouse_path(@warehouse.name)
                        else
                           render "edit"
                        end
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "show")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Glitchy")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "withdraw")
               warehouseFound = Warehouse.find_by_id(getWarehouseParams("WarehouseId"))
               if(warehouseFound && (current_user && current_user.pouch.privilege == "Glitchy"))
                  points = 0
                  if(warehouseFound.profit > 0)
                     warehouseFound.treasury += warehouseFound.profit
                     points = warehouseFound.profit
                     warehouseFound.profit = 0
                  elsif(warehouseFound.hoardpoints > 0)
                     warehouseFound.treasury += warehouseFound.hoardpoints
                     points = warehouseFound.hoardpoints
                     warehouseFound.hoardpoints = 0
                  end

                  #Saves the points that the warehouse has retrieved
                  if(points > 0)
                     @warehouse = warehouseFound
                     @warehouse.save
                     flash[:success] = "#{points} points have been added to the treasury!"
                  else
                     flash[:error] = "There are no points available!"
                  end
                  redirect_to warehouse_path(warehouseFound.name)
               else
                  redirect_to root_path
               end
            elsif(type == "tsetup" || type == "transfer" || type == "transferpost")
               #Determines whether if we need to setup the transfer
               if(type == "tsetup")
                  warehouseFound = Warehouse.find_by_id(getWarehouseParams("WarehouseId"))
               elsif(type == "transfer")
                  passedInValues = params[:format]
                  warehouseFound = Warehouse.find_by_id(passedInValues)
               else
                  warehouseFound = Warehouse.find_by_id(getWarehouseParams("WarehouseId"))
               end
               
               #Performs the actual transfer of points and emeralds
               if(warehouseFound && (current_user && current_user.pouch.privilege == "Glitchy"))
                  if(type == "tsetup")
                     redirect_to warehouses_transfer_path(warehouseFound.id)
                  else
                     @warehouse = warehouseFound
                     if(type == "transferpost")
                        dpoints = params[:hoard][:amount]
                        demeralds = params[:hoard][:emeralds]
                        dpoints = dpoints.to_i
                        demeralds = demeralds.to_i
                        if(@warehouse.treasury - dpoints >= 0 && @warehouse.emeralds - demeralds >= 0)
                           @warehouse.treasury -= dpoints
                           @warehouse.emeralds -= demeralds
                           hoard = Dragonhoard.find_by_id(1)
                           hoard.warepoints += (dpoints * 0.60).round
                           hoard.emeralds += (demeralds * 0.30).round
                           @dragonhoard = hoard
                           @dragonhoard.save
                           @warehouse.save
                           glitchy = User.find_by_vname("Glitchy")
                           economyTransaction("Sink", dpoints, "Warehouse", glitchy.id, "Points")
                           economyTransaction("Sink", demeralds, "Warehouse", glitchy.id, "Emeralds")
                           economyTransaction("Source", (dpoints * 0.60).round, "Hoard", glitchy.id, "Points")
                           economyTransaction("Source", (demeralds * 0.30).round, "Hoard", glitcy.id, "Emeralds")
                           flash[:success] = "#{dpoints} points and #{demeralds} emeralds have been transfered to the hoard!"
                        else
                           flash[:error] = "Point or Emerald donations can't exceed the warehouse's treasury!"
                        end
                        redirect_to warehouse_path(@warehouse.name)
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "buyitem" || type == "buypet")
               logged_in = current_user
               warehouseFound = Warehouse.find_by_id(getWarehouseParams("WarehouseId"))
               if(type == "buypet")
                  wareIndex = getWarehouseParams("Petindex")
                  ware = Wpetden.find_by_id(getWarehouseParams("WdenId"))
                  petname = getWarehouseParams("Partnername")
                  description = getWarehouseParams("Partnerdescription")
                  validPurchase = (warehouseFound && ware && wareIndex)
                  cost = 0
                  emeralds = 0
                  if(logged_in.partners.count > 0)
                     cost = getWarecost(getWareItems(wareIndex, ware, "Den"), wareIndex, ware, "Den", "Point")
                     emeralds = getWarecost(getWareItems(wareIndex, ware, "Den"), wareIndex, ware, "Den", "Emerald")
                  end
                  buyable = ((logged_in.pouch.amount - cost) >= 0 && (logged_in.pouch.emeraldamount - emeralds) >= 0)
                  if(logged_in && logged_in.gameinfo.startgame && validPurchase && buyable)
                     pet = Creature.find_by_id(getWareItems(wareIndex, ware, "Den"))
                     petCount = logged_in.partners.count
                     partner = storePartner(logged_in, pet)
                     @partner = partner
                     buildPartner = false
                     if(petCount > 0 && @partner.save)
                        logged_in.pouch.amount -= cost
                        logged_in.pouch.emeraldamount -= emeralds
                        @pouch = logged_in.pouch
                        @pouch.save
                        if(pet.user_id != logged_in.id)
                           owner = Pouch.find_by_user_id(pet.user_id)
                           points = (cost  * 0.20).round
                           ems = (emeralds * 0.08).round
                           owner.amount += points
                           owner.emeraldamount += ems
                           @owner = owner
                           @owner.save
                           profitP = cost - points
                           profitE = emeralds - ems
                           economyTransaction("Source", points, pet.creaturetype.name, owner.user.id, "Points")
                           economyTransaction("Source", ems, pet.creaturetype.name, owner.user.id, "Emeralds")
                        else
                           profitP = cost
                           profitE = emeralds
                        end
                        #Gives the points to the warehouse
                        warehouseFound.profit += profitP
                        warehouseFound.emeralds += profitE
                        economyTransaction("Sink", cost, pet.creaturetype.name, logged_in.id, "Points")
                        economyTransaction("Sink", emeralds, pet.creaturetype.name, logged_in.id, "Points")
                        economyTransaction("Tax", profitP, pet.creaturetype.name, "None", "Points")
                        economyTransaction("Tax", profitE, pet.creaturetype.name, "None", "Emeralds")
                        @warehouse = warehouseFound
                        @warehouse.save
                        buildPartner = true
                     elsif(petCount == 0 && @partner.save)
                        buildPartner = true
                     end
                     
                     if(buildPartner)
                        #Builds the partners attributes
                        newEquip = Equip.new(params[:equip])
                        newEquip.partner_id = partner.id
                        @equip = newEquip
                        @equip.save
                        newFight = Fight.new(params[:fight])
                        newFight.partner_id = partner.id
                        @fight = newFight
                        @fight.save
                           
                        #Saves the updated warehouse inventory
                        updateWares(wareIndex, ware, "Den")
                        @wpetden = ware
                        @wpetden.save
                        flash[:success] = "Pet #{@partner.name} was added to the party!"
                        redirect_to user_partner_path(partner.user, partner)
                     else
                        flash[:error] = "Partner name or description was empty or spaces were used instead of - as part of the name!"
                        redirect_to warehouse_path(warehouseFound.name)
                     end
                  else
                     if(logged_in && !logged_in.gameinfo.startgame)
                        flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                        redirect_to edit_gameinfo_path(logged_in.gameinfo)
                     elsif(!buyable)
                        flash[:error] = "The user didn't have enough points/emeralds to afford the pet!"
                        redirect_to root_path
                     else
                        flash[:error] = "The pet the user selected was an invalid id!"
                        redirect_to root_path
                     end
                  end                  
               else
                  wareIndex = getWarehouseParams("Slotindex")
                  ware = Witemshelf.find_by_id(getWarehouseParams("WshelfId"))
                  slotFound = Inventoryslot.find_by_id(getWarehouseParams("SlotId"))
                  validPurchase = (warehouseFound && slotFound && ware && wareIndex && (slotFound.inventory_id == logged_in.inventory.id))
                  cost = getWarecost(getWareItems(wareIndex, ware, "Shelf"), wareIndex, ware, "Shelf", "Point")
                  emeralds = getWarecost(getWareItems(wareIndex, ware, "Shelf"), wareIndex, ware, "Shelf", "Emerald")
                  buyable = ((logged_in.pouch.amount - cost) >= 0 && (logged_in.pouch.emeraldamount - emeralds) >= 0)
                  room = storeitem(slotFound, getWareItems(wareIndex, ware, "Shelf"))
                  if(logged_in && logged_in.gameinfo.startgame && validPurchase && buyable && room)
                     #Buys item
                     logged_in.pouch.amount -= cost
                     logged_in.pouch.emeraldamount -= emeralds
                     @pouch = logged_in.pouch
                     @pouch.save
                     updateWares(wareIndex, ware, "Shelf")
                     @witemshelf = ware
                     @witemshelf.save
                     @inventoryslot = slotFound
                     @inventoryslot.save
                     item = Item.find_by_id(getWareItems(wareIndex, ware, "Shelf"))
                     if(item.user_id != logged_in.id)
                        owner = Pouch.find_by_user_id(item.user_id)
                        points = (cost * 0.20).round
                        ems = (emeralds * 0.08).round
                        owner.amount += points
                        owner.emeraldamount += ems
                        @owner = owner
                        @owner.save
                        profitP = cost - points
                        profitE = emeralds - ems
                        economyTransaction("Source", points, item.itemtype.name, owner.user.id, "Points")
                        economyTransaction("Source", ems, item.itemtype.name, owner.user.id, "Emeralds")
                     else
                        profitP = cost
                        profitE = emeralds
                     end
                     #Gives the points to the warehouse
                     warehouseFound.profit += profitP
                     warehouseFound.emeralds += profitE
                     economyTransaction("Sink", cost, item.itemtype.name, logged_in.id, "Points")
                     economyTransaction("Sink", emeralds, item.itemtype.name, logged_in.id, "Points")
                     economyTransaction("Tax", profitP, item.itemtype.name, "None", "Points")
                     economyTransaction("Tax", profitE, item.itemtype.name, "None", "Emeralds")
                     @warehouse = warehouseFound
                     @warehouse.save
                     flash[:success] = "Item #{item.name} was added to the inventory!"
                     redirect_to user_inventory_path(@inventoryslot.inventory.user, @inventoryslot.inventory)
                  else
                     if(logged_in && !logged_in.gameinfo.startgame)
                        flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                        redirect_to edit_gameinfo_path(logged_in.gameinfo)
                     elsif(!room)
                        flash[:error] = "The user doesn't have enough room to store the item!"
                     elsif(!buyable)
                        flash[:error] = "The user didn't have enough points/emeralds to afford the item!"
                     else
                        flash[:error] = "The item the user selected was an invalid id!"
                     end
                     redirect_to root_path
                  end
               end
            end
         end
      end
end
