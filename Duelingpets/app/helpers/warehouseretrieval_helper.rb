module WarehouseretrievalHelper

   private
      def checkWarehouse(ware, type)
         if(type == "Den")
            #Sets up variables for the den slots
            slota = ((ware.creature1_id.nil? && ware.creature2_id.nil?) && (ware.creature3_id.nil? && ware.creature4_id.nil?))
            slotb = ((ware.creature5_id.nil? && ware.creature6_id.nil?) && (ware.creature7_id.nil? && ware.creature8_id.nil?))
            slotc = ((ware.creature9_id.nil? && ware.creature10_id.nil?) && (ware.creature11_id.nil? && ware.creature12_id.nil?))
            slotd = ((ware.creature13_id.nil? && ware.creature14_id.nil?) && (ware.creature15_id.nil? && ware.creature16_id.nil?))
            slotValue = (slota && slotb && slotc && slotd)
         else
            #Sets up variables for the shelf slots
            slota = ((ware.item1_id.nil? && ware.item2_id.nil?) && (ware.item3_id.nil? && ware.item4_id.nil?))
            slotb = ((ware.item5_id.nil? && ware.item6_id.nil?) && (ware.item7_id.nil? && ware.item8_id.nil?))
            slotc = ((ware.item9_id.nil? && ware.item10_id.nil?) && (ware.item11_id.nil? && ware.item12_id.nil?))
            slotd = ((ware.item13_id.nil? && ware.item14_id.nil?) && (ware.item15_id.nil? && ware.item16_id.nil?))
            slote = ((ware.item17_id.nil? && ware.item18_id.nil?) && (ware.item19_id.nil? && ware.item20_id.nil?))
            slotf = ((ware.item21_id.nil? && ware.item22_id.nil?) && (ware.item23_id.nil? && ware.item24_id.nil?))
            slotg = ((ware.item25_id.nil? && ware.item26_id.nil?) && (ware.item27_id.nil? && ware.item28_id.nil?))
            sloth = (ware.item29_id.nil? && ware.item30_id.nil?)
            slotValue = (slota && slotb && slotc && slotd && slote && slotf && slotg && sloth)
         end
         
         #Determines if we have any creatures or items stored in the warehouse
         noObjects = false
         if(slotValue)
            noObjects = true
         end
         return noObjects
      end
      
      def getWareItems(wareIndex, ware, type)
         #Sets up the initial variables
         piobject = nil
         wareFound = false
         wareIndex = wareIndex.to_i
         
         #Determines where in the warehouse an item or creature is stored
         if(wareIndex == 1)
            if(type == "Den")
               piobject = Creature.find_by_id(ware.creature1_id)
            else
               piobject = Item.find_by_id(ware.item1_id)
            end
            wareFound = true
         elsif(wareIndex == 2)
            if(type == "Den")
               piobject = Creature.find_by_id(ware.creature2_id)
            else
               piobject = Item.find_by_id(ware.item2_id)
            end
            wareFound = true
         elsif(wareIndex == 3)
            if(type == "Den")
               piobject = Creature.find_by_id(ware.creature3_id)
            else
               piobject = Item.find_by_id(ware.item3_id)
            end
            wareFound = true
         elsif(wareIndex == 4)
            if(type == "Den")
               piobject = Creature.find_by_id(ware.creature4_id)
            else
               piobject = Item.find_by_id(ware.item4_id)
            end
            wareFound = true
         elsif(wareIndex == 5)
            if(type == "Den")
               piobject = Creature.find_by_id(ware.creature5_id)
            else
               piobject = Item.find_by_id(ware.item5_id)
            end
            wareFound = true
         end

         #Checks additional slots if not found         
         if(!wareFound)
            if(wareIndex == 6)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature6_id)
               else
                  piobject = Item.find_by_id(ware.item6_id)
               end
               wareFound = true
            elsif(wareIndex == 7)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature7_id)
               else
                  piobject = Item.find_by_id(ware.item7_id)
               end
               wareFound = true
            elsif(wareIndex == 8)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature8_id)
               else
                  piobject = Item.find_by_id(ware.item8_id)
               end
               wareFound = true
            elsif(wareIndex == 9)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature9_id)
               else
                  piobject = Item.find_by_id(ware.item9_id)
               end
               wareFound = true
            elsif(wareIndex == 10)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature10_id)
               else
                  piobject = Item.find_by_id(ware.item10_id)
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found         
         if(!wareFound)
            if(wareIndex == 11)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature11_id)
               else
                  piobject = Item.find_by_id(ware.item11_id)
               end
               wareFound = true
            elsif(wareIndex == 12)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature12_id)
               else
                  piobject = Item.find_by_id(ware.item12_id)
               end
               wareFound = true
            elsif(wareIndex == 13)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature13_id)
               else
                  piobject = Item.find_by_id(ware.item13_id)
               end
               wareFound = true
            elsif(wareIndex == 14)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature14_id)
               else
                  piobject = Item.find_by_id(ware.item14_id)
               end
               wareFound = true
            elsif(wareIndex == 15)
               if(type == "Den")
                  piobject = Creature.find_by_id(ware.creature15_id)
               else
                  piobject = Item.find_by_id(ware.item15_id)
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found         
         if(!wareFound)
            if(type == "Den")
               if(wareIndex == 16)
                  piobject = Creature.find_by_id(ware.creature16_id)
                  wareFound = true
               end
            else
               if(wareIndex == 16)
                  piobject = Item.find_by_id(ware.item16_id)
                  wareFound = true
               elsif(wareIndex == 17)
                  piobject = Item.find_by_id(ware.item17_id)
                  wareFound = true
               elsif(wareIndex == 18)
                  piobject = Item.find_by_id(ware.item18_id)
                  wareFound = true
               elsif(wareIndex == 19)
                  piobject = Item.find_by_id(ware.item19_id)
                  wareFound = true
               elsif(wareIndex == 20)
                  piobject = Item.find_by_id(ware.item20_id)
                  wareFound = true
               end
            end
         end
         
         #Checks additional slots for shelves if item is not found
         if(type == "Shelf" && !wareFound)
            if(wareIndex == 21)
               piobject = Item.find_by_id(ware.item21_id)
               wareFound = true
            elsif(wareIndex == 22)
               piobject = Item.find_by_id(ware.item22_id)
               wareFound = true
            elsif(wareIndex == 23)
               piobject = Item.find_by_id(ware.item23_id)
               wareFound = true
            elsif(wareIndex == 24)
               piobject = Item.find_by_id(ware.item24_id)
               wareFound = true
            elsif(wareIndex == 25)
               piobject = Item.find_by_id(ware.item25_id)
               wareFound = true
            end
         end
         
         #Checks additional slots for shelves if item is not found
         if(type == "Shelf" && !wareFound)
            if(wareIndex == 26)
               piobject = Item.find_by_id(ware.item26_id)
               wareFound = true
            elsif(wareIndex == 27)
               piobject = Item.find_by_id(ware.item27_id)
               wareFound = true
            elsif(wareIndex == 28)
               piobject = Item.find_by_id(ware.item28_id)
               wareFound = true
            elsif(wareIndex == 29)
               piobject = Item.find_by_id(ware.item29_id)
               wareFound = true
            elsif(wareIndex == 30)
               piobject = Item.find_by_id(ware.item30_id)
               wareFound = true
            end
         end
         
         #Returns the warehouse item or pet's id if found
         value = piobject
         if(wareFound)
            value = piobject.id
         end
         return value
      end
      
      def getWareStats(wareid, waretype, type)
         #Sets up the initial variables
         piobject = nil
         value = 0

         #Retrieves the creature or item from the warehouse
         if(waretype == "Den")
            piobject = Creature.find_by_id(wareid)
         else
            piobject = Item.find_by_id(wareid)
         end
         
         #Determines what information to display back to the user
         if(type == "Name")
            value = piobject.name
            #Might consider making flag just retired instead of pet and item
            if(waretype == "Den" && piobject.retiredpet)
               value += " [Retired]"
            elsif(waretype == "Shelf" && piobject.retireditem)
               value += " [Retired]"
            end
         elsif(type == "Creator" || type == "User")
            value = piobject.user
            if(type == "Creator")
               value = piobject.user.vname
            end
         elsif(type == "Image" || type == "Imagecheck")
            if(waretype == "Den")
               value = (piobject.image.to_s != "")
               if(type == "Image")
                  value = piobject.image_url(:thumb)
               end
            else
               value = (piobject.itemart.to_s != "")
               if(type == "Image")
                  value = piobject.itemart_url(:thumb)
               end
            end
         elsif(type == "Rarity")
            value = piobject.rarity
         elsif(type == "PItype")
            if(waretype == "Den")
               value = piobject.creaturetype.name
               if(piobject.starter)
                  value += " [Starter]"
               end
            else
               piobject.itemtype.name
               if(piobject.equipable)
                  value += " [Equipable]"
               end
            end
         elsif(waretype == "Den" && type == "Lives")
            value = piobject.lives
            if(piobject.unlimitedlives)
               value += " [Unl]"
            end
         elsif(waretype == "Shelf" && type == "Durability")
            value = piobject.durability
         end
         return value
      end
      
      def getWarecost(wareid, wareIndex, ware, waretype, type)
         #Sets up the initial variables
         piobject = nil
         wareFound = false
         value = 0
         
         #Determines what type of object we are looking at
         if(waretype == "Den")
            piobject = Creature.find_by_id(wareid)
         else
            piobject = Item.find_by_id(wareid)
         end
         if(type == "Emerald")
            value = piobject.emeraldcost
         elsif(type == "Point")
            tax = 0 #Temporary code till item or creature tax is added
            value = piobject.cost + tax
         end
         
         #Adds the tax to points or returns the quantity
         if(type != "Emerald")
            if(wareIndex == 1)
               if(type == "Quantity")
                  value = ware.qty1
               else
                  value += ware.tax1
               end
               wareFound = true
            elsif(wareIndex == 2)
               if(type == "Quantity")
                  value = ware.qty2
               else
                  value += ware.tax2
               end
               wareFound = true
            elsif(wareIndex == 3)
               if(type == "Quantity")
                  value = ware.qty3
               else
                  value += ware.tax3
               end
               wareFound = true
            elsif(wareIndex == 4)
               if(type == "Quantity")
                  value = ware.qty4
               else
                  value += ware.tax4
               end
               wareFound = true
            elsif(wareIndex == 5)
               if(type == "Quantity")
                  value = ware.qty5
               else
                  value += ware.tax5
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found
         if(type != "Emerald" && !wareFound)
            if(wareIndex == 6)
               if(type == "Quantity")
                  value = ware.qty6
               else
                  value += ware.tax6
               end
               wareFound = true
            elsif(wareIndex == 7)
               if(type == "Quantity")
                  value = ware.qty7
               else
                  value += ware.tax7
               end
               wareFound = true
            elsif(wareIndex == 8)
               if(type == "Quantity")
                  value = ware.qty8
               else
                  value += ware.tax8
               end
               wareFound = true
            elsif(wareIndex == 9)
               if(type == "Quantity")
                  value = ware.qty9
               else
                  value += ware.tax9
               end
               wareFound = true
            elsif(wareIndex == 10)
               if(type == "Quantity")
                  value = ware.qty10
               else
                  value += ware.tax10
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found
         if(type != "Emerald" && !wareFound)
            if(wareIndex == 11)
               if(type == "Quantity")
                  value = ware.qty11
               else
                  value += ware.tax11
               end
               wareFound = true
            elsif(wareIndex == 12)
               if(type == "Quantity")
                  value = ware.qty12
               else
                  value += ware.tax12
               end
               wareFound = true
            elsif(wareIndex == 13)
               if(type == "Quantity")
                  value = ware.qty13
               else
                  value += ware.tax13
               end
               wareFound = true
            elsif(wareIndex == 14)
               if(type == "Quantity")
                  value = ware.qty14
               else
                  value += ware.tax14
               end
               wareFound = true
            elsif(wareIndex == 15)
               if(type == "Quantity")
                  value = ware.qty15
               else
                  value += ware.tax15
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found
         if(type != "Emerald" && !wareFound)
            if(waretype == "Den")
               if(wareIndex == 16)
                  if(type == "Quantity")
                     value = ware.qty16
                  else
                     value += ware.tax16
                  end
                  wareFound = true
               end
            else
               if(wareIndex == 16)
                  if(type == "Quantity")
                     value = ware.qty16
                  else
                     value += ware.tax16
                  end
                  wareFound = true
               elsif(wareIndex == 17)
                  if(type == "Quantity")
                     value = ware.qty17
                  else
                    value += ware.tax17
                  end
                  wareFound = true
               elsif(wareIndex == 18)
                  if(type == "Quantity")
                     value = ware.qty18
                  else
                     value += ware.tax18
                  end
                  wareFound = true
               elsif(wareIndex == 19)
                  if(type == "Quantity")
                     value = ware.qty19
                  else
                     value += ware.tax19
                  end
                  wareFound = true
               elsif(wareIndex == 20)
                  if(type == "Quantity")
                     value = ware.qty20
                  else
                     value += ware.tax20
                  end
                  wareFound = true
               end
            end
         end
         
         #Checks additional slots for shelves if item is not found
         if(type != "Emerald" && waretype == "Shelf" && !wareFound)
            if(wareIndex == 21)
               if(type == "Quantity")
                  value = ware.qty21
               else
                  value += ware.tax21
               end
               wareFound = true
            elsif(wareIndex == 22)
               if(type == "Quantity")
                  value = ware.qty22
               else
                  value += ware.tax22
               end
               wareFound = true
            elsif(wareIndex == 23)
               if(type == "Quantity")
                  value = ware.qty23
               else
                  value += ware.tax23
               end
               wareFound = true
            elsif(wareIndex == 24)
               if(type == "Quantity")
                  value = ware.qty24
               else
                  value += ware.tax24
               end
               wareFound = true
            elsif(wareIndex == 25)
               if(type == "Quantity")
                  value = ware.qty25
               else
                  value += ware.tax25
               end
               wareFound = true
            end
         end
         
         #Checks additional slots for shelves if item is not found
         if(type != "Emerald" && waretype == "Shelf" && !wareFound)
            if(wareIndex == 26)
               if(type == "Quantity")
                  value = ware.qty26
               else
                  value += ware.tax26
               end
               wareFound = true
            elsif(wareIndex == 27)
               if(type == "Quantity")
                  value = ware.qty27
               else
                  value += ware.tax27
               end
               wareFound = true
            elsif(wareIndex == 28)
               if(type == "Quantity")
                  value = ware.qty28
               else
                  value += ware.tax28
               end
               wareFound = true
            elsif(wareIndex == 29)
               if(type == "Quantity")
                  value = ware.qty29
               else
                  value += ware.tax29
               end
               wareFound = true
            elsif(wareIndex == 30)
               if(type == "Quantity")
                  value = ware.qty30
               else
                  value += ware.tax30
               end
               wareFound = true
            end
         end
         return value
      end
      
      def getWaretype(wareid, waretype, type)
         value = 0
         if(waretype == "Den")
            piobject = Creature.find_by_id(wareid)
            
            #Determines what stats we will display to the user
            if(type == "Magical" || type == "Stamina")
               if(type == "Magical")
                  msg1 = content_tag(:p, "Magical Stats")
                  msg2 = content_tag(:p, "MP: #{piobject.mp}")
                  msg3 = content_tag(:p, "Matk: #{piobject.matk} | Mdef: #{piobject.mdef}")
                  msg4 = content_tag(:p, "Magi: #{piobject.magi} | Mstr: #{piobject.mstr}")
                  value = (msg1 + msg2 + msg3 + msg4)
               else
                  msg1 = content_tag(:p, "Stamina Stats")
                  msg2 = content_tag(:p, "Fun: #{piobject.fun}")
                  msg3 = content_tag(:p, "Hunger: #{piobject.hunger}")
                  msg4 = content_tag(:p, "Thirst: #{piobject.thirst}")
                  value = (msg1 + msg2 + msg3 + msg4)
               end
            elsif(type == "Physical")
               msg1 = content_tag(:p, "Physical Stats")
               msg2 = content_tag(:p, "Level: #{piobject.level}")
               msg3 = content_tag(:p, "HP: #{piobject.hp}")
               msg4 = content_tag(:p, "Atk: #{piobject.atk} | Def: #{piobject.def}")
               msg5 = content_tag(:p, "Agi: #{piobject.agility} | Strength: #{piobject.strength}")
               value = (msg1 + msg2 + msg3 + msg4 + msg5)
            end
         else
            piobject = Item.find_by_id(wareid)
            itype = piobject.itemtype.name
            
            #Determines what stats we will display to the user
            if(itype == "Food" || itype == "Drink" || itype == "Toy")
               if(itype == "Food" || type == "Drink")
                  msg1 = content_tag(:p, "HP: #{piobject.hp}")
                  msg3 = content_tag(:p, "Fun: #{piobject.fun}")
                  msg2 = ""
                  if(type == "Food")
                     msg2 = content_tag(:p, "Hunger: #{piobject.hunger}")
                  else
                     msg2 = content_tag(:p, "Thirst: #{piobject.thirst}")      
                  end
                  value = (msg1 + msg2 + msg3)
               else
                  msg1 = content_tag(:p, "Fun: #{piobject.fun}")
                  msg2 = content_tag(:p, "Hunger: #{piobject.hunger}")
                  msg3 = content_tag(:p, "Thirst: #{piobject.thirst}")
                  value = (msg1 + msg2 + msg3)
               end
            else
               msg1 = content_tag(:p, "Atk: #{piobject.atk}")
               msg2 = content_tag(:p, "Def: #{piobject.def}")
               msg3 = content_tag(:p, "Agi: #{piobject.agility}")
               msg4 = content_tag(:p, "Str: #{piobject.strength}")
               value = (msg1 + msg2 + msg3 + msg4)
            end
         end
         return value
      end
      
      def storePartner(logged_in, creature)
         #Creating the partner entry
         newPartner = logged_in.partners.new(getWarehouseParams("Partner"))
         newPartner.adopted_on = currentTime
         newPartner.updated_on = currentTime
         newPartner.plevel = (creature.level - 1)
         newPartner.chp = creature.hp
         newPartner.hp = creature.hp
         newPartner.atk = creature.atk
         newPartner.def = creature.def
         newPartner.agility = creature.agility
         newPartner.strength = creature.strength
         newPartner.mlevel = (creature.level - 1)
         newPartner.cmp = creature.mp
         newPartner.mp = creature.mp
         newPartner.matk = creature.matk
         newPartner.mdef = creature.mdef
         newPartner.magi = creature.magi
         newPartner.mstr = creature.mstr
         newPartner.chunger = creature.hunger
         newPartner.hunger = creature.hunger
         newPartner.cthirst = creature.thirst
         newPartner.thirst = creature.thirst
         newPartner.cfun = creature.fun
         newPartner.fun = creature.fun
         newPartner.lives = creature.lives
         newPartner.creature_id = creature.id
         if(logged_in.partners.count == 0)
            newPartner.activepet = true
         end

         #Adoptcost should be based off the shopcost value
         newPartner.adoptcost = creature.cost
         newPartner.cost = creature.cost
         return newPartner
      end
      
      def storeitem(invslot, itemid)
         #Sets up the variables
         item = Item.find_by_id(itemid)
         durability = item.durability
         spacefound = false
         emptyspace = false
         
         #Determines which slot to put the item in
         if(invslot.item1_id && invslot.item1_id == itemid && invslot.startdur1 == durability)
            spacefound = true
            invslot.qty1 += 1
         elsif(invslot.item2_id && invslot.item2_id == itemid && invslot.startdur2 == durability)
            spacefound = true
            invslot.qty2 += 1
         elsif(invslot.item3_id && invslot.item3_id == itemid && invslot.startdur3 == durability)
            spacefound = true
            invslot.qty3 += 1
         elsif(invslot.item4_id && invslot.item4_id == itemid && invslot.startdur4 == durability)
            spacefound = true
            invslot.qty4 += 1
         else
            if(invslot.item1_id.nil?)
               emptyspace = true
               invslot.item1_id = itemid
               invslot.curdur1 = durability
               invslot.startdur1 = durability
               invslot.qty1 = 1
            elsif(invslot.item2_id.nil?)
               emptyspace = true
               invslot.item2_id = itemid
               invslot.curdur2 = durability
               invslot.startdur2 = durability
               invslot.qty2 = 1
            elsif(invslot.item3_id.nil?)
               emptyspace = true
               invslot.item3_id = itemid
               invslot.curdur3 = durability
               invslot.startdur3 = durability
               invslot.qty3 = 1
            elsif(invslot.item4_id.nil?)
               emptyspace = true
               invslot.item4_id = itemid
               invslot.curdur4 = durability
               invslot.startdur4 = durability
               invslot.qty4 = 1
            end
         end

         #Checks the additional itemslots
         if(!spacefound)
            if(invslot.item5_id && invslot.item5_id == itemid && invslot.startdur5 == durability)
               spacefound = true
               invslot.qty5 += 1
            elsif(invslot.item6_id && invslot.item6_id == itemid && invslot.startdur6 == durability)
               spacefound = true
               invslot.qty6 += 1
            elsif(invslot.item7_id && invslot.item7_id == itemid && invslot.startdur7 == durability)
               spacefound = true
               invslot.qty7 += 1
            elsif(invslot.item8_id && invslot.item8_id == itemid && invslot.startdur8 == durability)
               spacefound = true
               invslot.qty8 += 1
            else
               if(!emptyspace)
                  if(invslot.item5_id.nil?)
                     emptyspace = true
                     invslot.item5_id = itemid
                     invslot.curdur5 = durability
                     invslot.startdur5 = durability
                     invslot.qty5 = 1
                  elsif(invslot.item6_id.nil?)
                     emptyspace = true
                     invslot.item6_id = itemid
                     invslot.curdur6 = durability
                     invslot.startdur6 = durability
                     invslot.qty6 = 1
                  elsif(invslot.item7_id.nil?)
                     emptyspace = true
                     invslot.item7_id = itemid
                     invslot.curdur7 = durability
                     invslot.startdur7 = durability
                     invslot.qty7 = 1
                  elsif(invslot.item8_id.nil?)
                     emptyspace = true
                     invslot.item8_id = itemid
                     invslot.curdur8 = durability
                     invslot.startdur8 = durability
                     invslot.qty8 = 1
                  end
               end
            end
         end
         
         #Checks the additional itemslots
         if(!spacefound)
            if(invslot.item9_id && invslot.item9_id == itemid && invslot.startdur9 == durability)
               spacefound = true
               invslot.qty9 += 1
            elsif(invslot.item10_id && invslot.item10_id == itemid && invslot.startdur10 == durability)
               spacefound = true
               invslot.qty10 += 1
            elsif(invslot.item11_id && invslot.item11_id == itemid && invslot.startdur11 == durability)
               spacefound = true
               invslot.qty11 += 1
            elsif(invslot.item12_id && invslot.item12_id == itemid && invslot.startdur12 == durability)
               spacefound = true
               invslot.qty12 += 1
            else
               if(!emptyspace)
                  if(invslot.item9_id.nil?)
                     emptyspace = true
                     invslot.item9_id = itemid
                     invslot.curdur9 = durability
                     invslot.startdur9 = durability
                     invslot.qty9 = 1
                  elsif(invslot.item10_id.nil?)
                     emptyspace = true
                     invslot.item10_id = itemid
                     invslot.curdur10 = durability
                     invslot.startdur10 = durability
                     invslot.qty10 = 1
                  elsif(invslot.item11_id.nil?)
                     emptyspace = true
                     invslot.item11_id = itemid
                     invslot.curdur11 = durability
                     invslot.startdur11 = durability
                     invslot.qty11 = 1
                  elsif(invslot.item12_id.nil?)
                     emptyspace = true
                     invslot.item12_id = itemid
                     invslot.curdur12 = durability
                     invslot.startdur12 = durability
                     invslot.qty12 = 1
                  end
               end
            end
         end
         
         #Checks the additional itemslots
         if(!spacefound)
            if(invslot.item13_id && invslot.item13_id == itemid && invslot.startdur13 == durability)
               spacefound = true
               invslot.qty13 += 1
            elsif(invslot.item14_id && invslot.item14_id == itemid && invslot.startdur14 == durability)
               spacefound = true
               invslot.qty14 += 1
            else
               if(!emptyspace)
                  if(invslot.item13_id.nil?)
                     emptyspace = true
                     invslot.item13_id = itemid
                     invslot.curdur13 = durability
                     invslot.startdur13 = durability
                     invslot.qty13 = 1
                  elsif(invslot.item14_id.nil?)
                     emptyspace = true
                     invslot.item14_id = itemid
                     invslot.curdur14 = durability
                     invslot.startdur14 = durability
                     invslot.qty14 = 1
                  end
               end
            end
         end
         
         #Checks to see if there is room for the item
         roomspace = false
         if(spacefound || emptyspace)
            roomspace = true
         end
         return roomspace
      end
      
      def updateWares(wareIndex, ware, type)
         wareFound = false
         wareIndex = wareIndex.to_i
         
         #Determines which part of the warehouse to decrement
         if(wareIndex == 1)
            if(ware.qty1 > 1)
               ware.qty1 -= 1
            else
               ware.qty1 = 0
               ware.tax1 = 0
               if(type == "Den")
                  ware.creature1_id = nil
               else
                  ware.item1_id = nil
               end
            end
            wareFound = true
         elsif(wareIndex == 2)
            if(ware.qty2 > 1)
               ware.qty2 -= 1
            else
               ware.qty2 = 0
               ware.tax2 = 0
               if(type == "Den")
                  ware.creature2_id = nil
               else
                  ware.item2_id = nil
               end
            end
            wareFound = true
         elsif(wareIndex == 3)
            if(ware.qty3 > 1)
               ware.qty3 -= 1
            else
               ware.qty3 = 0
               ware.tax3 = 0
               if(type == "Den")
                  ware.creature3_id = nil
               else
                  ware.item3_id = nil
               end
            end
            wareFound = true
         elsif(wareIndex == 4)
            if(ware.qty4 > 1)
               ware.qty4 -= 1
            else
               ware.qty4 = 0
               ware.tax4 = 0
               if(type == "Den")
                  ware.creature4_id = nil
               else
                  ware.item4_id = nil
               end
            end
            wareFound = true
         elsif(wareIndex == 5)
            if(ware.qty5 > 1)
               ware.qty5 -= 1
            else
               ware.qty5 = 0
               ware.tax5 = 0
               if(type == "Den")
                  ware.creature5_id = nil
               else
                  ware.item5_id = nil
               end
            end
            wareFound = true
         end

         #Checks additional slots if not found         
         if(!wareFound)
            if(wareIndex == 6)
               if(ware.qty6 > 1)
                  ware.qty6 -= 1
               else
                  ware.qty6 = 0
                  ware.tax6 = 0
                  if(type == "Den")
                     ware.creature6_id = nil
                  else
                     ware.item6_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 7)
               if(ware.qty7 > 1)
                  ware.qty7 -= 1
               else
                  ware.qty7 = 0
                  ware.tax7 = 0
                  if(type == "Den")
                     ware.creature7_id = nil
                  else
                     ware.item7_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 8)
               if(ware.qty8 > 1)
                  ware.qty8 -= 1
               else
                  ware.qty8 = 0
                  ware.tax8 = 0
                  if(type == "Den")
                     ware.creature8_id = nil
                  else
                     ware.item8_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 9)
               if(ware.qty9 > 1)
                  ware.qty9 -= 1
               else
                  ware.qty9 = 0
                  ware.tax9 = 0
                  if(type == "Den")
                     ware.creature9_id = nil
                  else
                     ware.item9_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 10)
               if(ware.qty10 > 1)
                  ware.qty10 -= 1
               else
                  ware.qty10 = 0
                  ware.tax10 = 0
                  if(type == "Den")
                     ware.creature10_id = nil
                  else
                     ware.item10_id = nil
                  end
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found
         if(!wareFound)
            if(wareIndex == 11)
               if(ware.qty11 > 1)
                  ware.qty11 -= 1
               else
                  ware.qty11 = 0
                  ware.tax11 = 0
                  if(type == "Den")
                     ware.creature11_id = nil
                  else
                     ware.item11_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 12)
               if(ware.qty12 > 1)
                  ware.qty12 -= 1
               else
                  ware.qty12 = 0
                  ware.tax12 = 0
                  if(type == "Den")
                     ware.creature12_id = nil
                  else
                     ware.item12_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 13)
               if(ware.qty13 > 1)
                  ware.qty13 -= 1
               else
                  ware.qty13 = 0
                  ware.tax13 = 0
                  if(type == "Den")
                     ware.creature13_id = nil
                  else
                     ware.item13_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 14)
               if(ware.qty14 > 1)
                  ware.qty14 -= 1
               else
                  ware.qty14 = 0
                  ware.tax14 = 0
                  if(type == "Den")
                     ware.creature14_id = nil
                  else
                     ware.item14_id = nil
                  end
               end
               wareFound = true
            elsif(wareIndex == 15)
               if(ware.qty15 > 1)
                  ware.qty15 -= 1
               else
                  ware.qty15 = 0
                  ware.tax15 = 0
                  if(type == "Den")
                     ware.creature15_id = nil
                  else
                     ware.item15_id = nil
                  end
               end
               wareFound = true
            end
         end
         
         #Checks additional slots if not found
         if(!wareFound)
            if(type == "Den")
               if(wareIndex == 16)
                  if(ware.qty16 > 1)
                     ware.qty16 -= 1
                  else
                     ware.qty16 = 0
                     ware.tax16 = 0
                     ware.creature16_id = nil
                  end
               end
               wareFound = true
            else
               if(wareIndex == 16)
                  if(ware.qty16 > 1)
                     ware.qty16 -= 1
                  else
                     ware.qty16 = 0
                     ware.tax16 = 0
                     ware.item16_id = nil
                  end
                  wareFound = true
               elsif(wareIndex == 17)
                  if(ware.qty17 > 1)
                     ware.qty17 -= 1
                  else
                     ware.qty17 = 0
                     ware.tax17 = 0
                     ware.item17_id = nil
                  end
                  wareFound = true
               elsif(wareIndex == 18)
                  if(ware.qty18 > 1)
                     ware.qty18 -= 1
                  else
                     ware.qty18 = 0
                     ware.tax18 = 0
                     ware.item18_id = nil
                  end
                  wareFound = true
               elsif(wareIndex == 19)
                  if(ware.qty19 > 1)
                     ware.qty19 -= 1
                  else
                     ware.qty19 = 0
                     ware.tax19 = 0
                     ware.item19_id = nil
                  end
                  wareFound = true
               elsif(wareIndex == 20)
                  if(ware.qty20 > 1)
                     ware.qty20 -= 1
                  else
                     ware.qty20 = 0
                     ware.tax20 = 0
                     ware.item20_id = nil
                  end
                  wareFound = true
               end
            end
         end
         
         #Checks additional slots for shelves if item is not found
         if(type == "Shelf" && !wareFound)
            if(wareIndex == 21)
               if(ware.qty21 > 1)
                  ware.qty21 -= 1
               else
                  ware.qty21 = 0
                  ware.tax21 = 0
                  ware.item21_id = nil
               end
               wareFound = true
            elsif(wareIndex == 22)
               if(ware.qty22 > 1)
                  ware.qty22 -= 1
               else
                  ware.qty22 = 0
                  ware.tax22 = 0
                  ware.item22_id = nil
               end
               wareFound = true
            elsif(wareIndex == 23)
               if(ware.qty23 > 1)
                  ware.qty23 -= 1
               else
                  ware.qty23 = 0
                  ware.tax23 = 0
                  ware.item23_id = nil
               end
               wareFound = true
            elsif(wareIndex == 24)
               if(ware.qty24 > 1)
                  ware.qty24 -= 1
               else
                  ware.qty24 = 0
                  ware.tax24 = 0
                  ware.item24_id = nil
               end
               wareFound = true
            elsif(wareIndex == 25)
               if(ware.qty25 > 1)
                  ware.qty25 -= 1
               else
                  ware.qty25 = 0
                  ware.tax25 = 0
                  ware.item25_id = nil
               end
               wareFound = true
            end
         end
         
         #Checks additional slots for shelves if item is not found
         if(type == "Shelf" && !wareFound)
            if(wareIndex == 26)
               if(ware.qty26 > 1)
                  ware.qty26 -= 1
               else
                  ware.qty26 = 0
                  ware.tax26 = 0
                  ware.item26_id = nil
               end
               wareFound = true
            elsif(wareIndex == 27)
               if(ware.qty27 > 1)
                  ware.qty27 -= 1
               else
                  ware.qty27 = 0
                  ware.tax27 = 0
                  ware.item27_id = nil
               end
               wareFound = true
            elsif(wareIndex == 28)
               if(ware.qty28 > 1)
                  ware.qty28 -= 1
               else
                  ware.qty28 = 0
                  ware.tax28 = 0
                  ware.item28_id = nil
               end
               wareFound = true
            elsif(wareIndex == 29)
               if(ware.qty29 > 1)
                  ware.qty29 -= 1
               else
                  ware.qty29 = 0
                  ware.tax29 = 0
                  ware.item29_id = nil
               end
               wareFound = true
            elsif(wareIndex == 30)
               if(ware.qty30 > 1)
                  ware.qty30 -= 1
               else
                  ware.qty30 = 0
                  ware.tax30 = 0
                  ware.item30_id = nil
               end
               wareFound = true
            end
         end
      end
end
