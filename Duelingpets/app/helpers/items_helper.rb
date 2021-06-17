module ItemsHelper

   private
      def getItemParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ItemId")
            value = params[:item_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Item")
            value = params.require(:item).permit(:name, :description, :hp, :atk, :def, :agility, :strength,
            :mp, :matk, :mdef, :magi, :mstr, :hunger, :thirst, :fun, :rarity, :starter, :emeraldcost, :itemart, :remote_itemart_url,
            :itemart_cache, :itemtype_id, :equipable, :durability)
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
            newTransaction.attribute = "Content"
         else
            newTransaction.attribute = "Treasury"
         end
         newTransaction.content_type = "Item"
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

      def getItemStats(item, type)
         stats = ""
         if(type == "Food")
            msg1 = content_tag(:p, "HP: #{item.hp}")
            msg2 = content_tag(:p, "Hunger: #{item.hunger}")
            msg3 = content_tag(:p, "Fun: #{item.fun}")
            stats = (msg1 + msg2 + msg3)
         elsif(type == "Drink")
            msg1 = content_tag(:p, "HP: #{item.hp}")
            msg2 = content_tag(:p, "Thirst: #{item.thirst}")
            msg3 = content_tag(:p, "Fun: #{item.fun}")
            stats = (msg1 + msg2 + msg3)
         elsif(type == "Weapon")
            msg1 = content_tag(:p, "Atk: #{item.atk}")
            msg2 = content_tag(:p, "Def: #{item.def}")
            msg3 = content_tag(:p, "Agi: #{item.agility}")
            msg4 = content_tag(:p, "Str: #{item.strength}")
            stats = (msg1 + msg2 + msg3 + msg4)
         elsif(type == "Toy")
            msg1 = content_tag(:p, "Fun: #{item.fun}")
            msg2 = content_tag(:p, "Hunger: #{item.hunger}")
            msg3 = content_tag(:p, "Thirst: #{item.thirst}")
            stats = (msg1 + msg2 + msg3)
         end
         return stats
      end

      def validateItemStats(cost)
         #Determines the error message
         if(cost == -1)
            message = "Strength can't be negative!"
         elsif(cost == -2)
            message = "Mstr can't be negative!"
         elsif(cost == -3)
            message = "Durability can't be 0!"
         elsif(cost == -4)
            message = "Rarity can't be 0!"
         elsif(cost == -5)
            message = "Item values can't be empty!"
         end
         flash[:error] = message
      end

      def getPetCalc(item)
         if(!item.hp.nil? && !item.atk.nil? && !item.def.nil? && !item.agility.nil? && !item.strength.nil? && !item.mp.nil? && !item.matk.nil? && !item.mdef.nil? && !item.magi.nil? && !item.mstr.nil? && !item.hunger.nil? && !item.thirst.nil? && !item.fun.nil? && !item.durability.nil? && !item.rarity.nil? && !item.itemtype.basecost.nil?)
            #Application that calculates cost
            results = `public/Resources/Code/itemcalc/calc #{item.hp} #{item.atk} #{item.def} #{item.agility} #{item.strength} #{item.mp} #{item.matk} #{item.mdef} #{item.magi} #{item.mstr} #{item.hunger} #{item.thirst} #{item.fun} #{item.durability} #{item.rarity} #{item.itemtype.basecost}`
            itemAttributes = results
            itemCost = itemAttributes
            @item = item
            @item.cost = itemCost
         else
            @item.cost = -5
         end
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userItems = userFound.items.order("reviewed_on desc, created_on desc")
               itemsReviewed = userItems.select{|item| (current_user && item.user_id == current_user.id) || item.reviewed}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allItems = Item.order("reviewed_on desc, created_on desc")
            itemsReviewed = allItems.select{|item| (current_user && item.user_id == current_user.id) || item.reviewed}
         end
         @items = Kaminari.paginate_array(itemsReviewed).page(getItemParams("Page")).per(10)
      end

      def optional
         value = getItemParams("User")
         return value
      end

      def editCommons(type)
         itemFound = Item.find_by_id(getItemParams("Id"))
         if(itemFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == itemFound.user_id) || logged_in.pouch.privilege == "Admin"))
               itemFound.updated_on = currentTime
               #Determines the type of itemtype the item belongs to
               allItemtypes = Itemtype.order("created_on desc")
               @itemtypes = allItemtypes
               itemFound.reviewed = false
               @item = itemFound
               @user = User.find_by_vname(itemFound.user.vname)
               if(type == "update")
                  if(@item.update_attributes(getItemParams("Item")))
                     flash[:success] = "Item #{@item.name} was successfully updated."
                     redirect_to user_item_path(@item.user, @item)
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
         itemFound = Item.find_by_name(getItemParams("Id"))
         if(itemFound)
            removeTransactions
            if(itemFound.reviewed || current_user && ((itemFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @item = itemFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == itemFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Removes the content and decrements the owner's pouch
                     price = itemFound.cost * 0.60
                     if(itemFound.user.pouch.amount - price >= 0)
                        itemFound.user.pouch.amount -= price
                        @pouch = itemFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", price, itemFound.user.id, "Points")
                        @item.destroy
                        flash[:success] = "#{itemFound.name} was successfully removed."
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to items_list_path
                        else
                           redirect_to user_items_path(itemFound.user)
                        end
                     else
                        flash[:error] = "#{@item.user.vname}'s has insufficient points to remove the item!"
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
            if(type == "index") #Guests
               removeTransactions
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(9)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(current_user && current_user.admin)
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  end
               else
                  indexCommons
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
                  userFound = User.find_by_vname(getItemParams("User"))
                  passedInValues = params[:format]
                  if(logged_in && userFound && !passedInValues.nil?)
                     itemtype = Itemtype.find_by_id(passedInValues)
                     if(logged_in.id == userFound.id)
                        newItem = logged_in.items.new
                        if(type == "create")
                           newItem = logged_in.items.new(getItemParams("Item"))
                           newItem.created_on = currentTime
                           newItem.updated_on = currentTime
                        end

                        @itemtype = itemtype
                        newItem.itemtype_id = itemtype.id
                        if(itemtype.name == "Weapon" || itemtype.name == "Armor")
                           newItem.equipable = true
                        end
                        @item = newItem
                        @user = userFound

                        if(type == "create")
                           getPetCalc(@item)
                           if(@item.cost >= 0)
                              if(@item.save)
                                 url = "http://www.duelingpets.net/items/review"
                                 ContentMailer.content_review(@item, "Item", url).deliver_now
                                 flash[:success] = "#{@item.name} was successfully created."
                                 redirect_to user_item_path(@user, @item)
                              else
                                 render "new"
                              end
                           else
                              validateItemStats(@item.cost)
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
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               itemMode = Maintenancemode.find_by_id(9)
               if(allMode.maintenance_on || itemMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/items/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allItems = Item.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        itemsToReview = allItems.select{|item| !item.reviewed}
                        @items = Kaminari.paginate_array(itemsToReview).page(getItemParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @items = allItems.page(getItemParams("Page")).per(10)
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
                  itemFound = Item.find_by_id(getItemParams("ItemId"))
                  if(itemFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           #Might revise this section later
                           itemFound.reviewed = true
                           itemFound.reviewed_on = currentTime
                           basecost = itemFound.itemtype.basecost
                           price = ((basecost + itemFound.cost) * 0.70).round
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price * rate.amount)
                           pouch = Pouch.find_by_user_id(itemFound.user_id)
                           #Add dreyterrium cost later
                           if(pouch.amount - price >= 0)
                              @item = itemFound
                              @item.save
                              pouch.amount -= price
                              @pouch = pouch
                              @pouch.save
                              hoard = Dragonhoard.find_by_id(1)
                              hoard.profit += tax
                              @hoard = hoard
                              @hoard.save
                              economyTransaction("Sink", price - tax, itemFound.user.id, "Points")
                              economyTransaction("Tax", tax, itemFound.user.id, "Points")
                              ContentMailer.content_approved(@item, "Item", price).deliver_now
                              flash[:success] = "#{@item.user.vname}'s item #{@item.name} was approved."
                              redirect_to items_review_path
                           else
                              flash[:error] = "Insufficient funds to create an item!"
                              redirect_to user_path(logged_in.id)
                           end
                        else
                           @item = itemFound
                           ContentMailer.content_denied(@item, "Item").deliver_now
                           flash[:success] = "#{@item.user.vname}'s item #{@item.name} was denied."
                           redirect_to items_review_path
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     render "webcontrols/crazybat"
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "junkdealer")
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
                        @item = itemnum
                        @invslot = slot
                        @points = (@item.cost * 0.20).round
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  raise "Illegal operation!"
               end
            elsif(type == "yesitem" || type == "noitem")
               logged_in = current_user
               slot = Inventoryslot.find_by_id(params[:inventoryslot_id])
               slotindex = params[:slotindex_id]
               if(logged_in && slotindex && slot)
                  if(slot.inventory.user_id == logged_in.id)
                     itemcost = getItemName(slotindex, slot, "Points")
                     if(type == "yesitem")
                        itemname = getItemName(slotindex, slot, "Name")
                        updateInventory(slotindex, slot, "Discard")
                        @inventoryslot = slot
                        @inventoryslot.save
                        logged_in.pouch.amount += (itemcost * 0.20)
                        @pouch = logged_in.pouch
                        @pouch.save
                        flash[:success] = "Item #{itemname} was succesfully sold!"
                        redirect_to user_inventory_path(@inventoryslot.inventory.user, @inventoryslot.inventory)
                     else
                        price = ((itemcost * 0.20) * 4)
                        if(logged_in.pouch.amount - price >= 0)
                           logged_in.pouch.amount -= price
                           @pouch = logged_in.pouch
                           @pouch.save
                        end
                        flash[:success] = "No worries youngen, come back when your ready. As you leave the junk dealer you notice your pouch is slightly lighter than it was before."
                        redirect_to user_path(slot.inventory.user)
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "choose" || type == "choosepost")
               logged_in = current_user
               if(logged_in)
                  allItemtypes = Itemtype.order("created_on desc")
                  @itemtypes = allItemtypes
                  if(type == "choosepost")
                     itemtype = Itemtype.find_by_id(params[:item][:itemtype_id])
                     redirect_to new_user_item_path(logged_in, itemtype.id)
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
