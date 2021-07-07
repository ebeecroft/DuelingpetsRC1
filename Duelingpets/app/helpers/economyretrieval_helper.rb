module EconomyretrievalHelper

   private
      def getAllEcontypes(type, timeframe)
         transaction = Economy.order("created_on desc")
         value = 0
         contents = 0
         if(type == "Treasury")
            contents = transaction.select{|economy| economy.econattr == "Treasury"}
         elsif(type == "Content")
            contents = transaction.select{|economy| economy.econattr == "Content"}
         elsif(type == "Funds")
            contents = transaction.select{|economy| economy.econattr == "Funds"}
         elsif(type == "Purchase")
            contents = transaction.select{|economy| economy.econattr == "Purchase"}
         elsif(type == "Communication")
            contents = transaction.select{|economy| economy.econattr == "Communication"}
         elsif(type == "Community")
            contents = transaction.select{|economy| economy.econattr == "Community"}
         elsif(type == "Cleanup")
            contents = transaction.select{|economy| economy.econattr == "Cleanup"}
         elsif(type == "Itemshelf")
            contents = transaction.select{|economy| economy.econattr == "Itemshelf"}
         elsif(type == "Petden")
            contents = transaction.select{|economy| economy.econattr == "Petden"}
         end
         
         if(timeframe != "All")
            #Primary hours
            mins30 = contents.select{|content| currentTime - content.created_on <= 30.minutes}
            mins60 = contents.select{|content| currentTime - content.created_on <= 60.minutes}
            hours2 = contents.select{|content| currentTime - content.created_on <= 2.hours}
            hours4 = contents.select{|content| currentTime - content.created_on <= 4.hours}
            hours6 = contents.select{|content| currentTime - content.created_on <= 6.hours}
         
            #Secondary hours
            hours8 = contents.select{|content| currentTime - content.created_on <= 8.hours}
            hours10 = contents.select{|content| currentTime - content.created_on <= 10.hours}
            hours12 = contents.select{|content| currentTime - content.created_on <= 12.hours}
            hours14 = contents.select{|content| currentTime - content.created_on <= 14.hours}
            hours16 = contents.select{|content| currentTime - content.created_on <= 16.hours}
         
            #Longer time
            day = contents.select{|content| currentTime - content.created_on <= 1.day}
            days2 = contents.select{|content| currentTime - content.created_on <= 2.days}
            days3 = contents.select{|content| currentTime - content.created_on <= 3.days}
            days4 = contents.select{|content| currentTime - content.created_on <= 4.days}
            days5 = contents.select{|content| currentTime - content.created_on <= 5.days}
            
            #Sums up the data for the particular timeframe
            if(timeframe == "30mins")
               value = mins30.count
            elsif(timeframe == "60mins")
               value = mins60.count - mins30.count
            elsif(timeframe == "2hours")
               value = hours2.count - mins60.count - mins30.count
            elsif(timeframe == "4hours")
               value = hours4.count - hours2.count - mins60.count - mins30.count
            elsif(timeframe == "6hours")
               value = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
            elsif(timeframe == "8hours")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               value = hours8.count - set1
            elsif(timeframe == "10hours")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               value = hours10.count - hours8.count - set1
            elsif(timeframe == "12hours")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               value = hours12.count - hours10.count - hours8.count - set1
            elsif(timeframe == "14hours")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               value = hours14.count - hours12.count - hours10.count - hours8.count - set1
            elsif(timeframe == "16hours")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               set2 = hours14.count - hours12.count - hours10.count - hours8.count - set1
               value = hours16.count - set2
            elsif(timeframe == "1day")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               set2 = hours14.count - hours12.count - hours10.count - hours8.count - set1
               value = day1.count - hours16.count - set2
            elsif(timeframe == "2days")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               set2 = hours14.count - hours12.count - hours10.count - hours8.count - set1
               value = days2.count - day1.count - hours16.count - set2
            elsif(timeframe == "3days")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               set2 = hours14.count - hours12.count - hours10.count - hours8.count - set1
               value = days3.count - days2.count - day1.count - hours16.count - set2
            elsif(timeframe == "4days")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               set2 = hours14.count - hours12.count - hours10.count - hours8.count - set1
               set3 = days3.count - days2.count - day1.count - hours16.count - set2
               value = days4.count - set3
            elsif(timeframe == "5days")
               set1 = hours6.count - hours4.count - hours2.count - mins60.count - mins30.count
               set2 = hours14.count - hours12.count - hours10.count - hours8.count - set1
               set3 = days3.count - days2.count - day1.count - hours16.count - set2
               value = days5.count - days4.count - set3
            end
         else
            value = contents.count
         end
         return value
      end
      
      def getEconomyChanges(type, timeframe, currencyType)
         transaction = Economy.order("created_on desc")
         sourcepoints = transaction.select{|economy| economy.econtype == "Source" && economy.econattr != "Treasury" && economy.currency == "Points"}
         sinkpoints = transaction.select{|economy| economy.econtype == "Sink" && economy.econattr != "Funds" && economy.currency == "Points"}
         sourceemeralds = transaction.select{|economy| economy.econtype == "Source" && economy.econattr != "Treasury" && economy.currency == "Emeralds"}
         sinkemeralds = transaction.select{|economy| economy.econtype == "Sink" && economy.econattr != "Funds" && economy.currency == "Emeralds"}
         currency = 0
         if(type == "Source")
            currency = sourcepoints.sum{|economy| economy.amount}
            if(currencyType == "Emeralds")
               currency = sourceemeralds.sum{|economy| economy.amount}
            end
         elsif(type == "Sink")
            currency = sinkpoints.sum{|economy| economy.amount}
            if(currencyType == "Emeralds")
               currency = sinkemeralds.sum{|economy| economy.amount}
            end
         elsif(type == "Change")
            currency = sourcepoints.sum{|economy| economy.amount} - sinkpoints.sum{|economy| economy.amount}
            if(currencyType == "Emeralds")
               currency = sourceemeralds.sum{|economy| economy.amount} - sinkemeralds.sum{|economy| economy.amount}
            end
         elsif(type == "Population")
            allPouches = Pouch.all
            bots = allPouches.select{|pouch| (pouch.privilege == "Bot" || pouch.privilege == "Glitchy") && pouch.activated}
            demos = allPouches.select{|pouch| pouch.privilege == "Trial" && pouch.activated}
            inactive = allPouches.select{|pouch| !pouch.activated}
            staff = allPouches.select{|pouch| ((pouch.privilege == "Admin" || pouch.privilege == "Keymaster") || (pouch.privilege == "Manager" || pouch.privilege == "Reviewer")) && pouch.activated}
            users = allPouches.select{|pouch| ((pouch.privilege != "Bot" && pouch.privilege != "Trial") && (pouch.privilege != "Admin" && pouch.privilege != "Glitchy")) && pouch.activated}
            
            #Overloading the currecyType to handle user population
            currency = users.count
            if(currencyType == "Bots")
               currency = bots.count
            elsif(currencyType == "Demos")
               currency = demos.count
            elsif(currencyType == "Inactive")
               currency = inactive.count
            elsif(currencyType == "Staff")
               currency = staff.count
            end
         elsif(type == "CurrencyP")
            #Point currency
            allPouches = Pouch.all
            bots = allPouches.select{|pouch| (pouch.privilege == "Bot" || pouch.privilege == "Glitchy") && pouch.activated}
            demos = allPouches.select{|pouch| pouch.privilege == "Trial" && pouch.activated}
            inactive = allPouches.select{|pouch| !pouch.activated}
            staff = allPouches.select{|pouch| ((pouch.privilege == "Admin" || pouch.privilege == "Keymaster") || (pouch.privilege == "Manager" || pouch.privilege == "Reviewer")) && pouch.activated}
            users = allPouches.select{|pouch| ((pouch.privilege != "Bot" && pouch.privilege != "Trial") && (pouch.privilege != "Admin" && pouch.privilege != "Glitchy")) && pouch.activated}
            
            currency = users.sum{|pouch| pouch.amount}
            if(currencyType == "Bots")
               points = bots.sum{|pouch| pouch.amount}
            elsif(currencyType == "Demos")
               points = demos.sum{|pouch| pouch.amount}
            elsif(currencyType == "Inactive")
               points = inactive.sum{|pouch| pouch.amount}
            elsif(currencyType == "Staff")
               points = staff.sum{|pouch| pouch.amount}
            end
         elsif(type == "CurrencyE")
            #Emerald currency
            allPouches = Pouch.all
            bots = allPouches.select{|pouch| (pouch.privilege == "Bot" || pouch.privilege == "Glitchy") && pouch.activated}
            demos = allPouches.select{|pouch| pouch.privilege == "Trial" && pouch.activated}
            inactive = allPouches.select{|pouch| !pouch.activated}
            staff = allPouches.select{|pouch| ((pouch.privilege == "Admin" || pouch.privilege == "Keymaster") || (pouch.privilege == "Manager" || pouch.privilege == "Reviewer")) && pouch.activated}
            users = allPouches.select{|pouch| ((pouch.privilege != "Bot" && pouch.privilege != "Trial") && (pouch.privilege != "Admin" && pouch.privilege != "Glitchy")) && pouch.activated}
            
            currency = users.sum{|pouch| pouch.emeraldamount}
            if(currencyType == "Bots")
               points = bots.sum{|pouch| pouch.emeraldamount}
            elsif(currencyType == "Demos")
               points = demos.sum{|pouch| pouch.emeraldamount}
            elsif(currencyType == "Inactive")
               points = inactive.sum{|pouch| pouch.emeraldamount}
            elsif(currencyType == "Staff")
               points = staff.sum{|pouch| pouch.emeraldamount}
            end
         elsif(type == "Dreyore")
            allPouches = Pouch.all
            monster = allPouches.select{|pouch| !pouch.firstdreyore}
            dreyore = monster.sum{|pouch| pouch.dreyoreamount}
            currency = dreyore
         end
         return currency
      end
      
      def getHoardChanges(type, timeframe, currencyType)
         transaction = Economy.order("created_on desc")
         sourcepoints = transaction.select{|economy| economy.econtype == "Tax" && economy.econattr == "Treasury" && economy.currency == "Points"}
         sinkpoints = transaction.select{|economy| economy.econtype == "Sink" && economy.econattr != "Funds" && economy.currency == "Points"}
         sourceemeralds = transaction.select{|economy| economy.econtype == "Tax" && economy.econattr == "Treasury" && economy.currency == "Emeralds"}
         sinkemeralds = transaction.select{|economy| economy.econtype == "Sink" && economy.econattr != "Funds" && economy.currency == "Emeralds"}
         currency = 0
         if(type == "Source")
            currency = sourcepoints.sum{|economy| economy.amount}
            if(currencyType == "Emeralds")
               currency = sourceemeralds.sum{|economy| economy.amount}
            end
         elsif(type == "Sink")
            currency = sinkpoints.sum{|economy| economy.amount}
            if(currencyType == "Emeralds")
               currency = sinkemeralds.sum{|economy| economy.amount}
            end
         elsif(type == "Change")
            currency = sourcepoints.sum{|economy| economy.amount} - sinkpoints.sum{|economy| economy.amount}
            if(currencyType == "Emeralds")
               currency = sourceemeralds.sum{|economy| economy.amount} - sinkemeralds.sum{|economy| economy.amount}
            end
         elsif(type == "Treasury")
            hoard = Dragonhoard.find_by_id(1)
            if(currencyType == "Points")
               currency = hoard.treasury
            elsif(currencyType == "Contest")
               currency = hoard.contestpoints
            elsif(currencyType == "Emeralds")
               currency = hoard.emeralds
            elsif(currencyType == "DreyoreN")
               dreyore = Dreyore.find_by_name("Newbie")
               currency = dreyore.cur
            elsif(currencyType == "DreyoreM")
               dreyore = Dreyore.find_by_name("Monster")
               currency = dreyore.cur
            elsif(currencyType == "Warepoints")
               warehouse = Warehouse.find_by_id(1)
               currency = warehouse.treasury
            elsif(currencyType == "Wareemeralds")
               warehouse = Warehouse.find_by_id(1)
               currency = warehouse.emeralds
            end
         end
         return currency
      end

      def getCurLimit(type, user, result)
         upgrade = Userupgrade.find_by_name(type)
         if(type == "Pouch")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free1 + user.pouch.pouchslot.member1))
            level = (user.pouch.amount.to_s + "/" + max.to_s)
         elsif(type == "Emerald")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free2 + user.pouch.pouchslot.member2))
            if(result == "Limit")
               level = (user.pouch.emeraldamount.to_s + "/" + max.to_s)
            else
               level = max - user.pouch.emeraldamount
            end
         elsif(type == "Dreyore")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free3 + user.pouch.pouchslot.member3))
            if(result == "Limit")
               level = (user.pouch.dreyoreamount.to_s + "/" + max.to_s)
            else
               level = max - user.pouch.dreyoreamount
            end
         elsif(type == "OCup")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free5 + user.pouch.pouchslot.member5))
            if(result == "Limit")
               level = (user.ocs.count.to_s + "/" + max.to_s)
            else
               level = max - user.ocs.count
            end
         elsif(type == "Blog")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free6 + user.pouch.pouchslot.member6))
            if(result == "Limit")
               level = (user.blogs.count.to_s + "/" + max.to_s)
            else
               level = max - user.blogs.count
            end
         elsif(type == "Gallery")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free7 + user.pouch.pouchslot.member7))
            if(result == "Limit")
               level = (user.galleries.count.to_s + "/" + max.to_s)
            else
               level = max - user.galleries.count
            end
         elsif(type == "Book")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free8 + user.pouch.pouchslot.member8))
            if(result == "Limit")
               level = (user.books.count.to_s + "/" + max.to_s)
            else
               level = max - user.books.count
            end
         elsif(type == "Jukebox")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free9 + user.pouch.pouchslot.member9))
            if(result == "Limit")
               level = (user.jukeboxes.count.to_s + "/" + max.to_s)
            else
               level = max - user.jukeboxes.count
            end
         elsif(type == "Channel")
            max = (upgrade.base + upgrade.baseinc * (user.pouch.pouchslot.free10 + user.pouch.pouchslot.member10))
            if(result == "Limit")
               level = (user.channels.count.to_s + "/" + max.to_s)
            else
               level = max - user.channels.count
            end
         end
         return level
      end
end
