module SlotparamsHelper

   private
      def getItemName(slotindex, inventoryslot, type)
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
         elsif(slotindex == "9")
            item = Item.find_by_id(inventoryslot.item9_id)
         elsif(slotindex == "10")
            item = Item.find_by_id(inventoryslot.item10_id)
         elsif(slotindex == "11")
            item = Item.find_by_id(inventoryslot.item11_id)
         elsif(slotindex == "12")
            item = Item.find_by_id(inventoryslot.item12_id)
         elsif(slotindex == "13")
            item = Item.find_by_id(inventoryslot.item13_id)
         elsif(slotindex == "14")
            item = Item.find_by_id(inventoryslot.item14_id)
         end

         name = ""
         if(type == "Name")
            name = item.name
            if(item.retireditem)
               name = item.name + "[Retired]"
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
         elsif(type == "Hunger")
            name = item.hunger
         elsif(type == "Thirst")
            name = item.thirst
         elsif(type == "Fun")
            name = item.fun
         elsif(type == "HP")
            name = item.hp
         elsif(type == "Id")
            name = item.id
         end
         return name
      end

      def getItemImage(slotindex, inventoryslot, type)
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
         elsif(slotindex == "9")
            item = Item.find_by_id(inventoryslot.item9_id)
         elsif(slotindex == "10")
            item = Item.find_by_id(inventoryslot.item10_id)
         elsif(slotindex == "11")
            item = Item.find_by_id(inventoryslot.item11_id)
         elsif(slotindex == "12")
            item = Item.find_by_id(inventoryslot.item12_id)
         elsif(slotindex == "13")
            item = Item.find_by_id(inventoryslot.item13_id)
         elsif(slotindex == "14")
            item = Item.find_by_id(inventoryslot.item14_id)
         end

         image = item.itemart
         if(type == "Image")
            image = item.itemart_url(:thumb)
         end
         return image
      end

      def getQuantity(slotindex, inventoryslot)
         quantity = -1
         if(slotindex == "1")
            quantity = inventoryslot.qty1
         elsif(slotindex == "2")
            quantity = inventoryslot.qty2
         elsif(slotindex == "3")
            quantity = inventoryslot.qty3
         elsif(slotindex == "4")
            quantity = inventoryslot.qty4
         elsif(slotindex == "5")
            quantity = inventoryslot.qty5
         elsif(slotindex == "6")
            quantity = inventoryslot.qty6
         elsif(slotindex == "7")
            quantity = inventoryslot.qty7
         elsif(slotindex == "8")
            quantity = inventoryslot.qty8
         elsif(slotindex == "9")
            quantity = inventoryslot.qty9
         elsif(slotindex == "10")
            quantity = inventoryslot.qty10
         elsif(slotindex == "11")
            quantity = inventoryslot.qty11
         elsif(slotindex == "12")
            quantity = inventoryslot.qty12
         elsif(slotindex == "13")
            quantity = inventoryslot.qty13
         elsif(slotindex == "14")
            quantity = inventoryslot.qty14
         end
         return quantity
      end

      def getStats(slotindex, inventoryslot)
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
         elsif(slotindex == "9")
            item = Item.find_by_id(inventoryslot.item9_id)
         elsif(slotindex == "10")
            item = Item.find_by_id(inventoryslot.item10_id)
         elsif(slotindex == "11")
            item = Item.find_by_id(inventoryslot.item11_id)
         elsif(slotindex == "12")
            item = Item.find_by_id(inventoryslot.item12_id)
         elsif(slotindex == "13")
            item = Item.find_by_id(inventoryslot.item13_id)
         elsif(slotindex == "14")
            item = Item.find_by_id(inventoryslot.item14_id)
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

      def getDurability(slotindex, inventoryslot, type)
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
         elsif(slotindex == "9")
            durability = inventoryslot.startdur9
            if(type == "Current")
               durability = inventoryslot.curdur9
            end
         elsif(slotindex == "10")
            durability = inventoryslot.startdur10
            if(type == "Current")
               durability = inventoryslot.curdur10
            end
         elsif(slotindex == "11")
            durability = inventoryslot.startdur11
            if(type == "Current")
               durability = inventoryslot.curdur11
            end
         elsif(slotindex == "12")
            durability = inventoryslot.startdur12
            if(type == "Current")
               durability = inventoryslot.curdur12
            end
         elsif(slotindex == "13")
            durability = inventoryslot.startdur13
            if(type == "Current")
               durability = inventoryslot.curdur13
            end
         elsif(slotindex == "14")
            durability = inventoryslot.startdur14
            if(type == "Current")
               durability = inventoryslot.curdur14
            end
         end
         return durability
      end

      def updateInventory(slotindex, inventoryslot, type)
         #Assigns the local variable values
         quantity = getQuantity(slotindex, inventoryslot)
         durability = getDurability(slotindex, inventoryslot, "Current")
         startdur = getDurability(slotindex, inventoryslot, "Starter")
         itemid = nil

         #Decrements the item values stored in the inventory
         if(durability > 1 && type == "Feedpet")
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

      def checkSlot(slotFound)
         noItems = false
         slota = ((slotFound.item1_id.nil? && slotFound.item2_id.nil?) && (slotFound.item3_id.nil? && slotFound.item4_id.nil?))
         slotb = ((slotFound.item5_id.nil? && slotFound.item6_id.nil?) && (slotFound.item7_id.nil? && slotFound.item8_id.nil?))
         slotc = ((slotFound.item9_id.nil? && slotFound.item10_id.nil?) && (slotFound.item11_id.nil? && slotFound.item12_id.nil?))
         slotd = (slotFound.item13_id.nil? && slotFound.item14_id.nil?)
         if(slota && slotb && slotc && slotd)
            noItems = true
         end
         return noItems
      end

      #Needs revision
      def storeitem(slotFound, itemFound)
         noRoom = false
         itemMatch = false
         if(!slotFound.item1_id.nil? && (slotFound.item1_id == itemFound.id && slotFound.startdur1 == itemFound.durability))
            slotFound.qty1 += 1
            itemMatch = true
         elsif(!slotFound.item2_id.nil? && (slotFound.item2_id == itemFound.id && slotFound.startdur2 == itemFound.durability))
            slotFound.qty2 += 1
            itemMatch = true
         elsif(!slotFound.item3_id.nil? && (slotFound.item3_id == itemFound.id && slotFound.startdur3 == itemFound.durability))
            slotFound.qty3 += 1
            itemMatch = true
         elsif(!slotFound.item4_id.nil? && (slotFound.item4_id == itemFound.id && slotFound.startdur4 == itemFound.durability))
            slotFound.qty4 += 1
            itemMatch = true
         elsif(!slotFound.item5_id.nil? && (slotFound.item5_id == itemFound.id && slotFound.startdur5 == itemFound.durability))
            slotFound.qty5 += 1
            itemMatch = true
         elsif(!slotFound.item6_id.nil? && (slotFound.item6_id == itemFound.id && slotFound.startdur6 == itemFound.durability))
            slotFound.qty6 += 1
            itemMatch = true
         elsif(!slotFound.item7_id.nil? && (slotFound.item7_id == itemFound.id && slotFound.startdur7 == itemFound.durability))
            slotFound.qty7 += 1
            itemMatch = true
         elsif(!slotFound.item8_id.nil? && (slotFound.item8_id == itemFound.id && slotFound.startdur8 == itemFound.durability))
            slotFound.qty8 += 1
            itemMatch = true
         elsif(!slotFound.item9_id.nil? && (slotFound.item9_id == itemFound.id && slotFound.startdur9 == itemFound.durability))
            slotFound.qty9 += 1
            itemMatch = true
         elsif(!slotFound.item10_id.nil? && (slotFound.item10_id == itemFound.id && slotFound.startdur10 == itemFound.durability))
            slotFound.qty10 += 1
            itemMatch = true
         elsif(!slotFound.item11_id.nil? && (slotFound.item11_id == itemFound.id && slotFound.startdur11 == itemFound.durability))
            slotFound.qty11 += 1
            itemMatch = true
         elsif(!slotFound.item12_id.nil? && (slotFound.item12_id == itemFound.id && slotFound.startdur12 == itemFound.durability))
            slotFound.qty12 += 1
            itemMatch = true
         elsif(!slotFound.item13_id.nil? && (slotFound.item13_id == itemFound.id && slotFound.startdur13 == itemFound.durability))
            slotFound.qty13 += 1
            itemMatch = true
         elsif(!slotFound.item14_id.nil? && (slotFound.item14_id == itemFound.id && slotFound.startdur14 == itemFound.durability))
            slotFound.qty14 += 1
            itemMatch = true
         end

         if(!itemMatch)
            if(slotFound.item1_id.nil?)
               slotFound.item1_id = itemFound.id
               slotFound.curdur1 = itemFound.durability
               slotFound.startdur1 = itemFound.durability
               slotFound.qty1 = 1
            elsif(slotFound.item2_id.nil?)
               slotFound.item2_id = itemFound.id
               slotFound.curdur2 = itemFound.durability
               slotFound.startdur2 = itemFound.durability
               slotFound.qty2 = 1
            elsif(slotFound.item3_id.nil?)
               slotFound.item3_id = itemFound.id
               slotFound.curdur3 = itemFound.durability
               slotFound.startdur3 = itemFound.durability
               slotFound.qty3 = 1
            elsif(slotFound.item4_id.nil?)
               slotFound.item4_id = itemFound.id
               slotFound.curdur4 = itemFound.durability
               slotFound.startdur4 = itemFound.durability
               slotFound.qty4 = 1
            elsif(slotFound.item5_id.nil?)
               slotFound.item5_id = itemFound.id
               slotFound.curdur5 = itemFound.durability
               slotFound.startdur5 = itemFound.durability
               slotFound.qty5 = 1
            elsif(slotFound.item6_id.nil?)
               slotFound.item6_id = itemFound.id
               slotFound.curdur6 = itemFound.durability
               slotFound.startdur6 = itemFound.durability
               slotFound.qty6 = 1
            elsif(slotFound.item7_id.nil?)
               slotFound.item7_id = itemFound.id
               slotFound.curdur7 = itemFound.durability
               slotFound.startdur7 = itemFound.durability
               slotFound.qty7 = 1
            elsif(slotFound.item8_id.nil?)
               slotFound.item8_id = itemFound.id
               slotFound.curdur8 = itemFound.durability
               slotFound.startdur8 = itemFound.durability
               slotFound.qty8 = 1
            elsif(slotFound.item9_id.nil?)
               slotFound.item9_id = itemFound.id
               slotFound.curdur9 = itemFound.durability
               slotFound.startdur9 = itemFound.durability
               slotFound.qty9 = 1
            elsif(slotFound.item10_id.nil?)
               slotFound.item10_id = itemFound.id
               slotFound.curdur10 = itemFound.durability
               slotFound.startdur10 = itemFound.durability
               slotFound.qty10 = 1
            elsif(slotFound.item11_id.nil?)
               slotFound.item11_id = itemFound.id
               slotFound.curdur11 = itemFound.durability
               slotFound.startdur11 = itemFound.durability
               slotFound.qty11 = 1
            elsif(slotFound.item12_id.nil?)
               slotFound.item12_id = itemFound.id
               slotFound.curdur12 = itemFound.durability
               slotFound.startdur12 = itemFound.durability
               slotFound.qty12 = 1
            elsif(slotFound.item13_id.nil?)
               slotFound.item13_id = itemFound.id
               slotFound.curdur13 = itemFound.durability
               slotFound.startdur13 = itemFound.durability
               slotFound.qty13 = 1
            elsif(slotFound.item14_id.nil?)
               slotFound.item14_id = itemFound.id
               slotFound.curdur14 = itemFound.durability
               slotFound.startdur14 = itemFound.durability
               slotFound.qty14 = 1
            else
               noRoom = true
            end
         end
         return noRoom
      end
end
