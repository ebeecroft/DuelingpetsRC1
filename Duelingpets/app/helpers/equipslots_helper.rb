module EquipslotsHelper

   private
      def getEquipslotParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "EquipId")
            value = params[:equip_id]
         elsif(type == "Equipslot")
            value = params.require(:equipslot).permit(:name, :equip_id)
         elsif(type == "ItemId")
            value = params[:equipslot][:item_id]
         elsif(type == "SlotId")
            value = params[:equipslot][:equipslot_id]
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
         newTransaction.content_type = "Equip"
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def getEquipItemName(slotindex, inventoryslot, type)
         item = -1
         if(slotindex == "1")
            item = Item.find_by_id(inventoryslot.item1_id)
         elsif(slotindex == "2")
            item = Item.find_by_id(inventoryslot.item2_id)
         elsif(slotindex == "3")
            item = Item.find_by_id(inventoryslot.item3_id)
         elsif(slotindex == "4")
            item = Item.find_by_id(inventoryslot.item4_id)
         elsif(slotindex == "5")
            item = Item.find_by_id(inventoryslot.item5_id)
         elsif(slotindex == "6")
            item = Item.find_by_id(inventoryslot.item6_id)
         elsif(slotindex == "7")
            item = Item.find_by_id(inventoryslot.item7_id)
         elsif(slotindex == "8")
            item = Item.find_by_id(inventoryslot.item8_id)
         end

         name = ""
         if(type == "Name")
            if(item.name != "")
               name = item.name
               if(item.retireditem)
                  name = item.name + "[Retired]"
               end
            end
         elsif(type == "Creator")
            name = item.user.vname
         elsif(type == "User")
            name = item.user
         elsif(type == "Rarity")
            name = item.rarity
         elsif(type == "Equip")
            name = item.equipable
         elsif(type == "Itemtype")
            name = item.itemtype.name
         elsif(type == "Points")
            name = item.cost
         elsif(type == "Emeralds")
            name = item.emeraldcost
         elsif(type == "Item")
            name = item
         end
         return name
      end

      def getEquipItemImage(slotindex, inventoryslot, type)
         item = -1
         if(slotindex == "1")
            item = Item.find_by_id(inventoryslot.item1_id)
         elsif(slotindex == "2")
            item = Item.find_by_id(inventoryslot.item2_id)
         elsif(slotindex == "3")
            item = Item.find_by_id(inventoryslot.item3_id)
         elsif(slotindex == "4")
            item = Item.find_by_id(inventoryslot.item4_id)
         elsif(slotindex == "5")
            item = Item.find_by_id(inventoryslot.item5_id)
         elsif(slotindex == "6")
            item = Item.find_by_id(inventoryslot.item6_id)
         elsif(slotindex == "7")
            item = Item.find_by_id(inventoryslot.item7_id)
         elsif(slotindex == "8")
            item = Item.find_by_id(inventoryslot.item8_id)
         end

         image = item.itemart
         if(type == "Image")
            image = item.itemart_url(:thumb)
         end
         return image
      end

      def getEquipStats(slotindex, inventoryslot)
         item = -1
         if(slotindex == "1")
            item = Item.find_by_id(inventoryslot.item1_id)
         elsif(slotindex == "2")
            item = Item.find_by_id(inventoryslot.item2_id)
         elsif(slotindex == "3")
            item = Item.find_by_id(inventoryslot.item3_id)
         elsif(slotindex == "4")
            item = Item.find_by_id(inventoryslot.item4_id)
         elsif(slotindex == "5")
            item = Item.find_by_id(inventoryslot.item5_id)
         elsif(slotindex == "6")
            item = Item.find_by_id(inventoryslot.item6_id)
         elsif(slotindex == "7")
            item = Item.find_by_id(inventoryslot.item7_id)
         elsif(slotindex == "8")
            item = Item.find_by_id(inventoryslot.item8_id)
         end

         stats = ""
         if(getItemName(slotindex, inventoryslot, "Itemtype") == "Food")
            msg1 = content_tag(:p, "HP: #{item.hp}")
            msg2 = content_tag(:p, "Hunger: #{item.hunger}")
            msg3 = content_tag(:p, "Fun: #{item.fun}")
            stats = (msg1 + msg2 + msg3)
         elsif(getItemName(slotindex, inventoryslot, "Itemtype") == "Drink")
            msg1 = content_tag(:p, "HP: #{item.hp}")
            msg2 = content_tag(:p, "Thirst: #{item.thirst}")
            msg3 = content_tag(:p, "Fun: #{item.fun}")
            stats = (msg1 + msg2 + msg3)
         elsif(getItemName(slotindex, inventoryslot, "Itemtype") == "Weapon")
            msg1 = content_tag(:p, "Atk: #{item.atk}")
            msg2 = content_tag(:p, "Def: #{item.def}")
            msg3 = content_tag(:p, "Agi: #{item.agility}")
            msg4 = content_tag(:p, "Str: #{item.strength}")
            stats = (msg1 + msg2 + msg3 + msg4)
         elsif(getItemName(slotindex, inventoryslot, "Itemtype") == "Toy")
            msg1 = content_tag(:p, "Fun: #{item.fun}")
            msg2 = content_tag(:p, "Hunger: #{item.hunger}")
            msg3 = content_tag(:p, "Thirst: #{item.thirst}")
            stats = (msg1 + msg2 + msg3)
         end
         return stats
      end

      def getEquipDurability(slotindex, inventoryslot, type)
         if(slotindex == "1")
            durability = inventoryslot.startdur1
            if(type == "Current")
               durability = inventoryslot.curdur1
            end
         elsif(slotindex == "2")
            durability = inventoryslot.startdur2
            if(type == "Current")
               durability = inventoryslot.curdur2
            end
         elsif(slotindex == "3")
            durability = inventoryslot.startdur3
            if(type == "Current")
               durability = inventoryslot.curdur3
            end
         elsif(slotindex == "4")
            durability = inventoryslot.startdur4
            if(type == "Current")
               durability = inventoryslot.curdur4
            end
         elsif(slotindex == "5")
            durability = inventoryslot.startdur5
            if(type == "Current")
               durability = inventoryslot.curdur5
            end
         elsif(slotindex == "6")
            durability = inventoryslot.startdur6
            if(type == "Current")
               durability = inventoryslot.curdur6
            end
         elsif(slotindex == "7")
            durability = inventoryslot.startdur7
            if(type == "Current")
               durability = inventoryslot.curdur7
            end
         elsif(slotindex == "8")
            durability = inventoryslot.startdur8
            if(type == "Current")
               durability = inventoryslot.curdur8
            end
         end
         return durability
      end

      def invUp(slotindex, inventoryslot, type)
         quantity = getQuantity(slotindex, inventoryslot)
         durability = getDurability(slotindex, inventoryslot, "Current")
         startdur = getDurability(slotindex, inventoryslot, "Starter")
         itemid = nil

         #Decrements the item values stored in the inventory
         if(durability > 1 && (type == "Feed" || type == "Drink"))
            durability -= 1
         elsif(quantity > 1)
            durability = startdur
            quantity -= 1
         else
            durability = 0
            quantity = 0
            startdur = 0
            itemEmpty = true
         end

         #Determines which inventory item to update
         if(slotindex == "1")
            #Store the updated values
            inventoryslot.qty1 = quantity
            inventoryslot.curdur1 = durability
            inventoryslot.startdur1 = startdur
            if(itemEmpty)
               inventoryslot.item1_id = itemid
            end
         elsif(slotindex == "2")
            #Store the updated values
            inventoryslot.qty2 = quantity
            inventoryslot.curdur2 = durability
            inventoryslot.startdur2 = startdur
            if(itemEmpty)
               inventoryslot.item2_id = itemid
            end
         elsif(slotindex == "3")
            #Store the updated values
            inventoryslot.qty3 = quantity
            inventoryslot.curdur3 = durability
            inventoryslot.startdur3 = startdur
            if(itemEmpty)
               inventoryslot.item3_id = itemid
            end
         elsif(slotindex == "4")
            #Store the updated values
            inventoryslot.qty4 = quantity
            inventoryslot.curdur4 = durability
            inventoryslot.startdur4 = startdur
            if(itemEmpty)
               inventoryslot.item4_id = itemid
            end
         elsif(slotindex == "5")
            #Store the updated values
            inventoryslot.qty5 = quantity
            inventoryslot.curdur5 = durability
            inventoryslot.startdur5 = startdur
            if(itemEmpty)
               inventoryslot.item5_id = itemid
            end
         elsif(slotindex == "6")
            #Store the updated values
            inventoryslot.qty6 = quantity
            inventoryslot.curdur6 = durability
            inventoryslot.startdur6 = startdur
            if(itemEmpty)
               inventoryslot.item6_id = itemid
            end
         elsif(slotindex == "7")
            #Store the updated values
            inventoryslot.qty7 = quantity
            inventoryslot.curdur7 = durability
            inventoryslot.startdur7 = startdur
            if(itemEmpty)
               inventoryslot.item7_id = itemid
            end
         elsif(slotindex == "8")
            #Store the updated values
            inventoryslot.qty8 = quantity
            inventoryslot.curdur8 = durability
            inventoryslot.startdur8 = startdur
            if(itemEmpty)
               inventoryslot.item8_id = itemid
            end
         elsif(slotindex == "9")
            #Store the updated values
            inventoryslot.qty9 = quantity
            inventoryslot.curdur9 = durability
            inventoryslot.startdur9 = startdur
            if(itemEmpty)
               inventoryslot.item9_id = itemid
            end
         elsif(slotindex == "10")
            #Store the updated values
            inventoryslot.qty10 = quantity
            inventoryslot.curdur10 = durability
            inventoryslot.startdur10 = startdur
            if(itemEmpty)
               inventoryslot.item10_id = itemid
            end
         elsif(slotindex == "11")
            #Store the updated values
            inventoryslot.qty11 = quantity
            inventoryslot.curdur11 = durability
            inventoryslot.startdur11 = startdur
            if(itemEmpty)
               inventoryslot.item11_id = itemid
            end
         elsif(slotindex == "12")
            #Store the updated values
            inventoryslot.qty12 = quantity
            inventoryslot.curdur12 = durability
            inventoryslot.startdur12 = startdur
            if(itemEmpty)
               inventoryslot.item12_id = itemid
            end
         elsif(slotindex == "13")
            #Store the updated values
            inventoryslot.qty13 = quantity
            inventoryslot.curdur13 = durability
            inventoryslot.startdur13 = startdur
            if(itemEmpty)
               inventoryslot.item13_id = itemid
            end
         elsif(slotindex == "14")
            #Store the updated values
            inventoryslot.qty14 = quantity
            inventoryslot.curdur14 = durability
            inventoryslot.startdur14 = startdur
            if(itemEmpty)
               inventoryslot.item14_id = itemid
            end
         end
      end

      def equipItem(slotindex, inventoryslot, equipslot)
         #Assigns the local variable values
         itemid = getItemName(slotindex, inventoryslot, "Id")
         durability = getDurability(slotindex, inventoryslot, "Current")
         startdur = getDurability(slotindex, inventoryslot, "Starter")
         noRoom = false

         #Store the new item
         if(equipslot.item1_id.nil?)
            equipslot.item1_id = itemid
            equipslot.curdur1 = durability
            equipslot.startdur1 = startdur
         elsif(equipslot.item2_id.nil?)
            equipslot.item2_id = itemid
            equipslot.curdur2 = durability
            equipslot.startdur2 = startdur
         elsif(equipslot.item3_id.nil?)
            equipslot.item3_id = itemid
            equipslot.curdur3 = durability
            equipslot.startdur3 = startdur
         elsif(equipslot.item4_id.nil?)
            equipslot.item4_id = itemid
            equipslot.curdur4 = durability
            equipslot.startdur4 = startdur
         elsif(equipslot.item5_id.nil?)
            equipslot.item5_id = itemid
            equipslot.curdur5 = durability
            equipslot.startdur5 = startdur
         elsif(equipslot.item6_id.nil?)
            equipslot.item6_id = itemid
            equipslot.curdur6 = durability
            equipslot.startdur6 = startdur
         elsif(equipslot.item7_id.nil?)
            equipslot.item7_id = itemid
            equipslot.curdur7 = durability
            equipslot.startdur7 = startdur
         elsif(equipslot.item8_id.nil?)
            equipslot.item8_id = itemid
            equipslot.curdur8 = durability
            equipslot.startdur8 = startdur
         else
            noRoom = true
         end
         return noRoom
      end

      def checkFoodlevel(petfood, petstat, type)
         #Checks the pet's food level
         overfilled = (petfood > (petstat + (petstat * 0.60).round))
         full = (petfood == petstat)
         maxfood = (petstat + (petstat * 0.60).round)
         danger = ((maxfood - petfood) < (maxfood * 0.15).round)
         deathflag = false

         if(overfilled)
            msg = "I am sorry to report that your pet has just died!"
            deathflag = true
         elsif(full)
            msg = "Your pet is becoming too full!"
            if(type == "Thirst")
               msg = "Your pet is drinking too many liquids!"
            end
         elsif(danger)
            msg = "Your pet is now full!"
            if(type == "Thirst")
               msg = "Your pet is no longer thirsty!"
            end
         else
            msg = "Your pet was fed some food"
         end
         flash[:success] = msg
         return deathflag
      end

      def feedpet(slotindex, inventoryslot, pet)
         itemid = getItemName(slotindex, inventoryslot, "Itemtype")
         hunger = getItemName(slotindex, inventoryslot, "Hunger")
         thirst = getItemName(slotindex, inventoryslot, "Thirst")
         fun = getItemName(slotindex, inventoryslot, "Fun")
         hp = getItemName(slotindex, inventoryslot, "HP")
         petfood = pet.chunger + hunger
         petstat = pet.hunger
         giveFood = true

         if(itemid == "Thirst")
            petfood = pet.cthirst + thirst
            petstat = pet.thirst
         end

         #Determines the pets current food
         if(pet.chp == pet.hp)
            if(itemid == "Food")
               if(pet.chunger < 4)
                  pet.chunger += hunger
                  if(pet.cfun + fun > 0)
                     pet.cfun += fun
                  else
                     pet.cfun = 0
                  end
               else
                  giveFood = false
                  flash[:error] = "Your pet is not hungry enough!"
               end
            else
               if(pet.cthirst < 4)
                  pet.cthirst += thirst
                  if(pet.cfun + fun > 0)
                     pet.cfun += fun
                  else
                     pet.cfun = 0
                  end
               else
                  giveFood = false
                  flash[:error] = "Your pet is not thirsty enough!"
               end
            end
         else
            petDead = checkFoodlevel(petfood, petstat, itemid)
            if(!pet.dead && !petDead)
               #Reduce the fun of the pet during feeding
               if(pet.cfun + fun > 0)
                  pet.cfun += fun
               else
                  pet.cfun = 0
               end

               #Increase the pets hp from eating food
               if(pet.chp + hp > pet.hp)
                  itemloss = (pet.chp + hp) - pet.hp
                  pet.chp = pet.hp
               else
                  pet.chp += hp
               end

               #Store the change in the pet's food values
               if(itemid == "Food")
                  pet.chunger += hunger
               else
                  pet.cthirst += thirst
               end
            else
               giveFood = false
               if(!pet.dead)
                  pet.dead = true
                  pet.chunger = 0
                  pet.cthirst = 0
                  pet.cfun = 0
                  pet.chp = 0
               end
            end
         end
         return giveFood
      end

      def isEquipSlotEmpty(inventoryslot)
         noItems = false
         slota = ((inventoryslot.item1_id.nil? && inventoryslot.item2_id.nil?) && (inventoryslot.item3_id.nil? && inventoryslot.item4_id.nil?))
         slotb = ((inventoryslot.item5_id.nil? && inventoryslot.item6_id.nil?) && (inventoryslot.item7_id.nil? && inventoryslot.item8_id.nil?))
         if(slota && slotb)
            noItems = true
         end
         return noItems
      end

      def editCommons(type)
         slotFound = Equipslot.find_by_id(getEquipslotParams("Id"))
         if(slotFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == slotFound.equip.partner.user.id) || logged_in.pouch.privilege == "Admin"))
               @equipslot = slotFound
               @equip = Equip.find_by_id(slotFound.equip.id)
               if(type == "update")
                  if(@equipslot.update_attributes(getEquipslotParams("Equipslot")))
                     flash[:success] = "Equipslot #{@equipslot.name} was successfully updated."
                     redirect_to partner_equip_path(@equip.partner, @equip)
                  else
                     render "edit"
                  end
               elsif(type == "destroy")
                  if(checkSlot(slotFound))
                     #Removes the equip and decrements the owner's pouch
                     equip = Fieldcost.find_by_name("Equipslotcleanup")
                     if(slotFound.user.pouch.amount - equip.amount >= 0)
                        slotFound.user.pouch.amount -= equip.amount
                        @pouch = slotFound.user.pouch
                        @pouch.save
                        economyTransaction("Tax", equip.amount, slotFound.user.id)
                        @equip.destroy
                        flash[:success] = "Equip slot #{slotFound.name} was successfully removed."
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to equips_path
                        else
                           redirect_to partner_equip_path(@equip.partner, @equip)
                        end
                     else
                        flash[:error] = "Owner has insufficient points to remove the equipslot!"
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
                  allEquips = Equipslot.all
                  @equipslots = Kaminari.paginate_array(allEquips).page(getEquipslotParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               creatureMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || creatureMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/creatures/maintenance"
                  end
               else
                  logged_in = current_user
                  equipFound = Equip.find_by_id(getEquipslotParams("EquipId"))
                  if((logged_in && equipFound) && (logged_in.id == equipFound.partner.user_id))
                     newSlot = equipFound.equipslots.new
                     if(type == "create")
                        newSlot = equipFound.equipslots.new(getEquipslotParams("Equipslot"))
                        if(equipFound.equipslots.count == 0)
                           newSlot.activeslot = true
                        end
                     end
                     @equip = equipFound
                     @equipslot = newSlot
                     if(type == "create")
                        equipslotcost = Fieldcost.find_by_name("Equipslot")
                        if(logged_in.pouch.amount - equipslotcost.amount >= 0)
                           if(@equipslot.save)
                              logged_in.pouch.amount -= equipslotcost.amount
                              @pouch = logged_in.pouch
                              @pouch.save
                              economyTransaction("Sink", equipslotcost, equipFound.user.id)
                              flash[:success] = "#{@equipslot.name} was successfully created."
                              redirect_to partner_equip_path(@equip.partner, @equip)
                           else
                              render "new"
                           end
                        else
                           flash[:error] = "Insufficient funds to create an equipslot!"
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
                  creatureMode = Maintenancemode.find_by_id(10)
                  if(allMode.maintenance_on || creatureMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/creatures/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "applyitem")
               logged_in = current_user
               if(logged_in)
                  action = Itemaction.find_by_id(params[:equipslot][:itemaction_id])
                  invslot = Inventoryslot.find_by_id(params[:equipslot][:inventoryslot_id])
                  slotindex = params[:equipslot][:slotindex_id]
                  if(logged_in.id == invslot.inventory.user_id)
                     if(slotindex.to_i > 0 && slotindex.to_i < 15)
                        myarray = [slotindex, invslot]
                        if(action.name == "Discard")
                           redirect_to items_junkdealer_path(myarray)
                        else
                           redirect_to equipslots_equippet_path(myarray)
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "equippet")
               logged_in = current_user
               passedInValues = params[:format]
               if(logged_in && !passedInValues.nil?)
                  slotindex, invslot = params[:format].split("/")
                  if(slotindex.to_s != "" && !invslot.to_s != "")
                     slot = Inventoryslot.find_by_id(invslot)
                     if(slot.inventory.user_id == logged_in.id)
                        #Finds the item the player is trying to get rid of
                        itemnum = getItemName(slotindex, slot, "Item")
                        @slotindex = slotindex
                        @invslot = slot
                        @item = itemnum
                        allActions = Itemaction.all
                        actions = allActions.select{|action| (getItemName(slotindex, slot, "Equip") && action.name == "Equip") || (getItemName(slotindex, slot, "Itemtype") == "Food" && action.name == "Feed")}
                        @actiongroup = actions
                        allPartners = Partner.all
                        mypartners = allPartners.select{|partner| partner.user_id == logged_in.id}
                        @pets = mypartners
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "useitem")
               logged_in = current_user
               slot = Inventoryslot.find_by_id(params[:inventoryslot_id])
               slotindex = params[:slotindex_id]
               partner = Partner.find_by_id(params[:equipslot][:partner_id])
               action = Itemaction.find_by_id(params[:equipslot][:itemaction_id])
               validItem = (slotindex && slot && partner && action)
               givePetFood = false
               if(logged_in && validItem)
                  if(slot.inventory.user_id == logged_in.id && partner.user_id == logged_in.id)
                     if(action.name == "Feed")
                        if(getItemName(slotindex, slot, "Itemtype") == "Food")
                           givePetFood = feedpet(slotindex, slot, partner)
                        elsif(getItemName(slotindex, slot, "Itemtype") == "Drink")
                           givePetFood = feedpet(slotindex, slot, partner)
                        else
                           raise "Invalid item selection!"
                        end
                        if(givePetFood)
                           #raise "My acition.name is: #{action.name}"
                           #updateInventory(slotindex, slot, action.name)
                           invUp(slotindex, slot, action.name)
                           @partner = partner
                           @partner.save
                           @slot = slot
                           @slot.save
                           flash[:success] = "Pet was successfully fed!"
                        end
                        redirect_to user_path(partner.user)
                     else
                        allEquipslots = partner.equip.equipslots.all
                        if(allEquipslots.count > 0)
                           activeslot = allEquipslots.select{|slot| slot.activeslot}
                           curslot = activeslot.first
                           equipslot = Equipslot.find_by_id(curslot.id)
                           equipItem(slotindex, slot, equipslot)
                           flash[:success] = "Pet equipped a #{getItemName(slotindex, slot, "Name")}!"
                           updateInventory(slotindex, slot, action.name)
                           @equipslot = equipslot
                           @equipslot.save
                           @slot = slot
                           @slot.save
                           redirect_to user_path(partner.user)
                        else
                           flash[:error] = "Pet has no equipslots available!"
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
         end
      end
end
