module VisitorretrievalHelper

   private
      def setLastpageVisited
         if(current_user)
            pouch = Pouch.find_by_user_id(current_user.id)
            pouch.last_visited = currentTime
            @pouch = pouch
            @pouch.save
         end
      end

      def getTime(user)
         value = ""
         userPouch = Pouch.find_by_id(user.id)
         if(getActivity(user) == "Inactive")
            value = userPouch.last_visited
         elsif(getActivity(user) == "Offline")
            value = userPouch.signed_out_at
         elsif(getActivity(user) == "Gone")
            value = userPouch.signed_out_at
         end
         return value
      end

      def getActivity(user)
         status = "Inoperable"
         userPouch = Pouch.find_by_id(user.id)
         if(userPouch.activated)
            if(!userPouch.signed_out_at)
               if(!userPouch.signed_in_at)
                  status = "Inoperable"
               elsif((currentTime - userPouch.last_visited) > 30.minutes)
                  status = "Inactive"
               else
                  status = "Online"
               end
            else
               if(userPouch.gone)
                  status = "Gone"
               else
                  status = "Offline"
               end
            end
         end         
         return status
      end

      def getVisitors(timeframe, content, contentType)
         visits = findVisitor(contentType, content)
         #Time values
         allVisits = visits.order("created_on desc")
         pastTwenty = allVisits.select{|visit| (currentTime - visit.created_on) <= 20.minutes}
         pastFourty = allVisits.select{|visit| (currentTime - visit.created_on) <= 40.minutes}
         pasthour = allVisits.select{|visit| (currentTime - visit.created_on) <= 1.hour}
         past2hours = allVisits.select{|visit| (currentTime - visit.created_on) <= 2.hours}
         past3hours = allVisits.select{|visit| (currentTime - visit.created_on) <= 3.hours}

         #Count values
         past20MinsCount = pastTwenty.count
         past40MinsCount = pastFourty.count - past20MinsCount
         pasthourCount = pasthour.count - past40MinsCount - past20MinsCount
         past2hoursCount = past2hours.count - pasthourCount - past40MinsCount - past20MinsCount
         past3hoursCount =  past3hours.count - past2hoursCount - pasthourCount - past40MinsCount - past20MinsCount

         #value = past20Count
         if(timeframe == "past20mins")
            value = past20MinsCount
         elsif(timeframe == "past40mins")
            value = past40MinsCount
         elsif(timeframe == "pasthour")
            value = pasthourCount
         elsif(timeframe == "past2hours")
            value = past2hoursCount
         elsif(timeframe == "past3hours")
            value = past3hoursCount
         end
         return value
      end

      def removeVisits(allVisits)
         oldVisits = allVisits.select{|visit| currentTime - visit.created_on > 3.hours}
         if(oldVisits.count > 0)
            oldVisits.each do |visit|
               @visit = visit
               @visit.destroy
            end
         end
      end

      def cleanupOldVisits
         allVisits = Uservisit.order("created_on desc")
         removeVisits(allVisits)
      end

      def saveVisit(content, visitor, contentType)
         allVisits = findVisitor(contentType, content).order("created_on desc")
         contentVisited = allVisits.select{|visit| ((currentTime - visit.created_on) < 10.minutes) && compareVisitor(contentType, visit, visitor)}
         if(contentVisited.count == 0)
            #Add visitor to list
            visit = contentFound.new(getVisitorParams(contentType))
            newVisit = visit
            newVisit.user_id = visitor.id
            if(contentType == "User")
               newVisit.from_user_id = visitor.id
            end

            #Save the new visit
            newVisit.created_on = currentTime
            @visit = newVisit
            @visit.save
         end
      end

      def findVisitor(contentType, content)
         visits = ""
         if(contentType == "User")
            visits = content.uservisits
         elsif(contentType == "Art")

         end
         return visits
      end

      def compareVisitor(contentType, visit, visitor)
         value = (visit.user_id == visitor.id)
         if(contentType == "User")
            value = (visit.from_user_id == visitor.id)
         end
         return value
      end

      def getVisitorParams(contentType)
         visitor = ""
         if(contentType == "User")
            visitor = params[:uservisit]
         elsif(contentType == "Art")
            visitor = params[:artvisit]
         end
         return visitor
      end

      def visitTimer(type, contentType, content)
         #Determines if we have visitors to our page
         if(type == "show")
            visitor = current_user
            if(visitor)
               userPouch = Pouch.find_by_user_id(visitor.id)
               userPouch.last_visited = currentTime
               @pouch = userPouch
               @pouch.save

               #Determines if we are looking at a user
               contentOwner = content.user_id
               if(contentType == "User")
                  contentOwner = content.id
               end

               if(visitor.id != contentOwner && !visitor.admin)
                  timer = Pagetimer.find_by_name(contentType)
                  if(timer.expiretime - currentTime <= 0)
                     value = timer.duration.minutes.from_now.utc
                     timer.expiretime = value
                     @pagetimer = timer
                     @pagetimer.save
                     saveVisit(content, visitor, contentType)
                  else
                     saveVisit(content, visitor, contentType)
                  end
               end
            end
         end
      end
end
