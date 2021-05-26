module EconomyretrievalHelper

   private
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

      def getEconomyChanges(type)
         econs = Economy.order("created_on desc")
         points = 0
         econpoints = []
         if(econs.count > 0)
            if(type == "Source")
               econpoints = econs.select{|economy| economy.name == "Source" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Sink")
               econpoints = econs.select{|economy| economy.name == "Sink" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Tax")
               econpoints = econs.select{|economy| economy.name == "Tax" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Transfer")
               econpoints = econs.select{|economy| economy.name == "Transfer" && (currentTime - economy.created_on) <= 6.hours}
            end
            points = econpoints.sum{|economy| economy.amount}
         end
         return points
      end

      def getPouchcontents(type)
         allPouches = Pouch.all
         points = 0
         if(allPouches.count > 0)
            if(type == "Bot" || type == "Botpop")
               pouches = allPouches.select{|pouch| pouch.privilege == "Bot" && pouch.activated}
            elsif(type == "User" || type == "Userpop")
               pouches = allPouches.select{|pouch| ((pouch.privilege != "Bot" && pouch.privilege != "Trial") && (pouch.privilege != "Admin" && pouch.privilege != "Glitchy")) && pouch.activated}
            end
            if(type == "Bot" || type == "User")
               points = pouches.sum{|pouch| pouch.amount}
            elsif(type == "Botpop" || type == "Userpop")
               points = pouches.count
            end
         end
         return points
      end

      def getTreasurypoints
         hoard = Dragonhoard.find_by_id(1)
         points = hoard.treasury
         return points
      end

      def getContestpoints
         hoard = Dragonhoard.find_by_id(1)
         points = hoard.contestpoints
         return points
      end

      def getEconomyvalue
         points = getEconomyChanges("Source") - getEconomyChanges("Sink")
         return points
      end

      def getHoardvalue
         points = (getTreasurypoints + getContestpoints) - getEconomyChanges("Tax")
         return points
      end

      def getWorldvalue
         points = (getPouchcontents("User") + getPouchcontents("Bot")) - getEconomyChanges("Source")
         return points
      end

      def getWorldchange
         points = getWorldvalue - getEconomyChanges("Sink")
         return points
      end

      def getHoardchange
         points = getHoardvalue - getEconomyChanges("Sink")
         return points
      end

      def getEcontypes(type)
         econs = Economy.order("created_on desc")
         contents = 0
         econContents = []
         if(econs.count > 0)
            if(type == "Content")
               econContents = econs.select{|economy| economy.econtype == "Content" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Treasury")
               econContents = econs.select{|economy| economy.econtype == "Treasury" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Community")
               econContents = econs.select{|economy| economy.econtype == "Community" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Purchase")
               econContents = econs.select{|economy| economy.econtype == "Purchase" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Cleanup")
               econContents = econs.select{|economy| economy.econtype == "Cleanup" && (currentTime - economy.created_on) <= 6.hours}
            elsif(type == "Funds")
               econContents = econs.select{|economy| economy.econtype == "Funds" && (currentTime - economy.created_on) <= 6.hours}
            end
            contents = econContents.count
         end
         return contents
      end
end
