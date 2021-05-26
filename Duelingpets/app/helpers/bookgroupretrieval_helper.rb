module BookgroupretrievalHelper

   private
      def getReadingGroup(user, type)
         group = user.userinfo.bookgroup_id
         if(type == "Name")
            group = user.userinfo.bookgroup.name
         end
         return group
      end

      def getWritingGroup(user, type)
         groupValue = ""
         age = (currentTime.year - user.birthday.year)
         month = (currentTime.month - user.birthday.month) / 12
         if(month < 0)
            age -= 1
         end

         #Determines the group
         if(age < 7)
            groupValue = 0
         elsif(age < 15)
            groupValue = 1
         elsif(age < 23)
            groupValue = 2
         elsif(age < 31)
            groupValue = 3
         elsif(age >= 31)
            groupValue = 4
         end
         if(type == "Name")
            if(groupValue > 0)
               bookgroup = Bookgroup.find_by_id(groupValue)
               groupValue = bookgroup.name
            else
               groupValue = "Lizardo"
            end
         elsif(type == "Age")
            groupValue = age
         end
         return groupValue
      end

      def getBookGroups(name)
         allUsers = User.all
         currentDate = Date.today
         nonBot = allUsers.select{|user| ((user.pouch.privilege != "Bot") && (user.pouch.privilege != "Trial")) && ((user.pouch.privilege != "Admin") && (user.pouch.privilege != "Glitchy"))}

         #Group values
         lizardo = nonBot.select{|user| getWritingGroup(user, "Age") < 7}
         rabbit = nonBot.select{|user| getWritingGroup(user, "Age")  < 15}
         blueland = nonBot.select{|user| getWritingGroup(user, "Age") < 23}
         silverwing = nonBot.select{|user| getWritingGroup(user, "Age") < 31}
         pantorian = nonBot.select{|user| getWritingGroup(user, "Age") >= 31}

         #Count values
         rabbitCount = rabbit.count - lizardo.count
         bluelandCount = blueland.count - rabbitCount - lizardo.count
         silverwingCount = silverwing.count - bluelandCount - rabbitCount - lizardo.count
         pantorianCount = pantorian.count
 
         value = 0
         if(name == "Rabbit")
            value = rabbitCount
         elsif(name == "Blueland")
            value = bluelandCount
         elsif(name == "Silverwing")
            value = silverwingCount
         elsif(name == "Pantorians")
            value = pantorianCount
         end
         return value
      end
end
