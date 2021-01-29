module EconomystatsHelper

   private
      def getTimeDifference(type, content)
         value = ""
         if(type == "User")
            value = (currentTime - content.joined_on)
         elsif(type == "Register")
            value = (currentTime - content.registered_on)
         elsif(type != "User")
            value = (currentTime - content.created_on)
         end
         return value
      end

      def getStatDifference(type, visit)
         value = (currentTime - visit.created_on)
         return value
      end

      def getReviewContent(type)
         value = 0
         if(type == "Creature")
            allContents = Creature.all
         elsif(type == "Monster")
            allContents = Monster.all
         elsif(type == "Item")
            allContents = Item.all
         elsif(type == "OC")
            allContents = Oc.all
         elsif(type == "Blog")
            allContents = Blog.all
         elsif(type == "Art")
            allContents = Art.all
         elsif(type == "Sound")
            allContents = Sound.all
         elsif(type == "Movie")
            allContents = Movie.all
         elsif(type == "Chapter")
            allContents = Chapter.all
         elsif(type == "Shout")
            allContents = Shout.all
         end
         review = allContents.select{|content| !content.reviewed}
         value = review.count
         return value
      end

      def getUserContent(user, type)
         value = 0
         if(type == "Blog" || type == "Adblog")
            allUserBlogs = user.blogs.all

            #Retrieves all the normal blogs that have been reviewed
            normalBlogs = allUserBlogs.select{|blog| blog.adbanner.to_s == "" && blog.largeimage1.to_s == "" && blog.largeimage2.to_s == "" && blog.largeimage3.to_s == "" && blog.smallimage1.to_s == "" && blog.smallimage2.to_s == "" && blog.smallimage3.to_s == "" && blog.smallimage4.to_s == "" && blog.smallimage5.to_s == ""}
            if(type == "Adblog")
               #Retrieves all the ad blogs that have been reviewed
               normalBlogs = allUserBlogs.select{|blog| blog.adbanner.to_s != "" || blog.largeimage1.to_s != "" || blog.largeimage2.to_s != "" || blog.largeimage3.to_s != "" || blog.smallimage1.to_s != "" || blog.smallimage2.to_s != "" || blog.smallimage3.to_s != "" || blog.smallimage4.to_s != "" || blog.smallimage5.to_s != ""}
            end
            reviewedBlogs = normalBlogs.select{|blog| blog.reviewed || (current_user && current_user.id == blog.user_id)}

            #Displays all the blogs to the blog owner
            if(current_user && current_user.id == user.id)
               reviewedBlogs = normalBlogs
            end
            value = reviewedBlogs.count
         elsif(type == "Activatedcolors" || type == "Inactivecolors")
            allUserColors = user.colorschemes.all
            activatedColors = allUserColors.select{|colorscheme| colorscheme.activated}
            if(type == "Inactivecolors")
               activatedColors = allUserColors.select{|colorscheme| !colorscheme.activated}
            end
            value = activatedColors.count
         elsif(type == "Shout" || type == "Pageshouts")
            allShouts = Shout.order("created_on desc")
            reviewedShouts = allShouts.select{|shout| shout.shoutbox_id == user.shoutbox.id && shout.reviewed}
            value = reviewedShouts.count
            if(type == "Pageshouts")
              #Shouts that get displayed on the user's show view
              @shouts = Kaminari.paginate_array(reviewedShouts).page(getUserParams("Page")).per(10)
              value = @shouts
            end
         elsif(type == "Tags")
            allTags = user.tags.order("created_on desc")
            value = allTags.count
         elsif(type == "Elements")
            allElements = user.elements.order("created_on desc")
            reviewedElements = allElements.select{|element| element.reviewed || (current_user && current_user.id == element.user_id)}
            value = reviewedElements.count
         elsif(type == "Monsters")
            allMonsters = user.monsters.order("created_on desc")
            reviewedMonsters = allMonsters.select{|monster| monster.reviewed || (current_user && current_user.id == monster.user_id)}
            value = reviewedMonsters.count
         elsif(type == "Creatures")
            allCreatures = user.creatures.order("created_on desc")
            reviewedCreatures = allCreatures.select{|creature| creature.reviewed || (current_user && current_user.id == creature.user_id)}
            value = reviewedCreatures.count
         elsif(type == "Partners")
            allPartners = user.partners.order("created_on desc")
            value = allPartners.count
         elsif(type == "Items")
            allItems = user.items.order("created_on desc")
            reviewedItems = allItems.select{|item| item.reviewed || (current_user && current_user.id == item.user_id)}
            value = reviewedItems.count
         elsif(type == "OCs")
            allOCs = user.ocs.order("created_on desc")
            reviewedOCs = allOCs.select{|oc| oc.reviewed || (current_user && current_user.id == oc.user_id)}
            value = reviewedOCs.count
         elsif(type == "Donors")
            value = user.donationbox.progress
         elsif(type == "Galleries")
            allGalleries = user.galleries.order("created_on desc")
            value = allGalleries.count
         elsif(type == "Channels")
            allChannels = user.channels.order("created_on desc")
            value = allChannels.count
         elsif(type == "Jukeboxes")
            allJukeboxes = user.jukeboxes.order("created_on desc")
            value = allJukeboxes.count
         elsif(type == "Bookworlds")
            allBookworlds = user.bookworlds.order("created_on desc")
            value = allBookworlds.count
         elsif(type == "PMs")
            allPMs = Pm.order("created_on desc")
            pms = allPMs.select{|pm| pm.pmbox.user_id == user.id}
            value = pms.count
         end
         return value
      end

      def getStatsTimeframe(type, timeframe)
         allContents = ""
         firstContent = ""

         if(type == "User")
            allContents = User.all
            if(allContents.count != 0)
               firstContent = User.first.joined_on.year
            end
         elsif(type == "OC")
            allContents = Oc.all
            if(allContents.count != 0)
               firstContent = Oc.first.created_on.year
            end
         elsif(type == "Item")
            allContents = Item.all
            if(allContents.count != 0)
               firstContent = Item.first.created_on.year
            end
         elsif(type == "Monster")
            allContents = Monster.all
            if(allContents.count != 0)
               firstContent = Monster.first.created_on.year
            end
         elsif(type == "Creature")
            allContents = Creature.all
            if(allContents.count != 0)
               firstContent = Creature.first.created_on.year
            end
         elsif(type == "PM")
            allContents = Pm.all
            if(allContents.count != 0)
               firstContent = Pm.first.created_on.year
            end
         elsif(type == "PMreply")
            allContents = Pmreply.all
            if(allContents.count != 0)
               firstContent = Pmreply.first.created_on.year
            end
         elsif(type == "Register")
            allContents = Registration.all
            if(allContents.count != 0)
               firstContent = Registration.first.registered_on.year
            end
         elsif(type == "Referral")
            allContents = Referral.all
            if(allContents.count != 0)
               firstContent = Referral.first.created_on.year
            end
         elsif(type == "Friend")
            #allContents = Friend.all
            #if(allContents.count != 0)
               #firstContent = Friend.first.created_on.year
            #end
         elsif(type == "Colorscheme")
            allContents = Colorscheme.all
            if(allContents.count != 0)
               firstContent = Colorscheme.first.created_on.year
            end
         elsif(type == "Gallery")
            allContents = Gallery.all
            if(allContents.count != 0)
               firstContent = Gallery.first.created_on.year
            end
         elsif(type == "Mainfolder")
            allContents = Mainfolder.all
            if(allContents.count != 0)
               firstContent = Mainfolder.first.created_on.year
            end
         elsif(type == "Subfolder")
            allContents = Subfolder.all
            if(allContents.count != 0)
               firstContent = Subfolder.first.created_on.year
            end
         elsif(type == "Art")
            allContents = Art.all
            if(allContents.count != 0)
               firstContent = Art.first.created_on.year
            end
         elsif(type == "Jukebox")
            allContents = Jukebox.all
            if(allContents.count != 0)
               firstContent = Jukebox.first.created_on.year
            end
         elsif(type == "Mainsheet")
            allContents = Mainsheet.all
            if(allContents.count != 0)
               firstContent = Mainsheet.first.created_on.year
            end
         elsif(type == "Subsheet")
            allContents = Subsheet.all
            if(allContents.count != 0)
               firstContent = Subsheet.first.created_on.year
            end
         elsif(type == "Sound")
            allContents = Sound.all
            if(allContents.count != 0)
               firstContent = Sound.first.created_on.year
            end
         elsif(type == "Channel")
            allContents = Channel.all
            if(allContents.count != 0)
               firstContent = Channel.first.created_on.year
            end
         elsif(type == "Mainplaylist")
            allContents = Mainplaylist.all
            if(allContents.count != 0)
               firstContent = Mainplaylist.first.created_on.year
            end
         elsif(type == "Subplaylist")
            allContents = Subplaylist.all
            if(allContents.count != 0)
               firstContent = Subplaylist.first.created_on.year
            end
         elsif(type == "Movie")
            allContents = Movie.all
            if(allContents.count != 0)
               firstContent = Movie.first.created_on.year
            end
         elsif(type == "Bookworld")
            allContents = Bookworld.all
            if(allContents.count != 0)
               firstContent = Bookworld.first.created_on.year
            end
         elsif(type == "Book")
            allContents = Book.all
            if(allContents.count != 0)
               firstContent = Book.first.created_on.year
            end
         elsif(type == "Chapter")
            allContents = Chapter.all
            if(allContents.count != 0)
               firstContent = Chapter.first.created_on.year
            end
         elsif(type == "Blog")
            allContents = Blog.all
            if(allContents.count != 0)
               firstContent = Blog.first.created_on.year
            end
         elsif(type == "Forum")
            #allContents = Forum.all
            #if(allContents.count != 0)
               #firstContent = Forum.first.created_on.year
            #end
         elsif(type == "Container")
            #allContents = Topiccontainer.all
            #if(allContents.count != 0)
               #firstContent = Topiccontainer.first.created_on.year
            #end
         elsif(type == "Maintopic")
            #allContents = Maintopic.all
            #if(allContents.count != 0)
               #firstContent = Maintopic.first.created_on.year
            #end
         elsif(type == "Subtopic")
            #allContents = Subtopic.all
            #if(allContents.count != 0)
               #firstContent = Subtopic.first.created_on.year
            #end
         elsif(type == "Narrative")
            #allContents = Narrative.all
            #if(allContents.count != 0)
               #firstContent = Narrative.first.created_on.year
            #end
         elsif(type == "Reply")
            #allContents = Reply.all
            #if(allContents.count != 0)
               #firstContent = Reply.first.created_on.year
            #end
         elsif(type == "Soundcritique")
            #allContents = Soundcomment.all
            #if(allContents.count != 0)
               #firstContent = Soundcomment.first.created_on.year
            #end
         elsif(type == "Soundcomment")
            #allContents = Soundcomment.all
            #if(allContents.count != 0)
               #firstContent = Soundcomment.first.created_on.year
            #end
         elsif(type == "Artcritique")
            #allContents = Artcomment.all
            #if(allContents.count != 0)
               #firstContent = Artcomment.first.created_on.year
            #end
         elsif(type == "Artcomment")
            #allContents = Artcomment.all
            #if(allContents.count != 0)
               #firstContent = Artcomment.first.created_on.year
            #end
         elsif(type == "Moviecritique")
            #allContents = Moviecomment.all
            #if(allContents.count != 0)
               #firstContent = Moviecomment.first.created_on.year
            #end
         elsif(type == "Moviecomment")
            #allContents = Moviecomment.all
            #if(allContents.count != 0)
               #firstContent = Moviecomment.first.created_on.year
            #end
         elsif(type == "Shout")
            allContents = Shout.all
            if(allContents.count != 0)
               firstContent = Shout.first.created_on.year
            end
         elsif(type == "Favoritesound")
            #allContents = Favoritesound.all
            #if(allContents.count != 0)
               #firstContent = Favoritesound.first.created_on.year
            #end
         elsif(type == "Soundstar")
            #allContents = Soundstar.all
            #if(allContents.count != 0)
               #firstContent = Soundstar.first.created_on.year
            #end
         elsif(type == "Favoriteart")
            #allContents = Favoriteart.all
            #if(allContents.count != 0)
               #firstContent = Favoriteart.first.created_on.year
            #end
         elsif(type == "Artstar")
            #allContents = Artstar.all
            #if(allContents.count != 0)
               #firstContent = Artstar.first.created_on.year
            #end
         elsif(type == "Favoritemovie")
            #allContents = Favoritemovie.all
            #if(allContents.count != 0)
               #firstContent = Favoritemovie.first.created_on.year
            #end
         elsif(type == "Moviestar")
            #allContents = Moviestar.all
            #if(allContents.count != 0)
               #firstContent = Moviestar.first.created_on.year
            #end
         elsif(type == "Blogstar")
            #allContents = Blogstar.all
            #if(allContents.count != 0)
               #firstContent = Blogstar.first.created_on.year
            #end
         elsif(type == "Watcher")
            #allContents = Watch.all
            #if(allContents.count != 0)
               #firstContent = Watch.first.created_on.year
            #end
         elsif(type == "Containersub")
            #allContents = Containersub.all
            #if(allContents.count != 0)
               #firstContent = Containersub.first.created_on.year
            #end
         elsif(type == "Maintopicsub")
            #allContents = Maintopicsub.all
            #if(allContents.count != 0)
               #firstContent = Maintopicsub.first.created_on.year
            #end
         elsif(type == "Subtopicsub")
            #allContents = Subtopicsub.all
            #if(allContents.count != 0)
               #firstContent = Subtopicsub.first.created_on.year
            #end
         elsif(type == "Forummod")
            #allContents = Forummod.all
            #if(allContents.count != 0)
               #firstContent = Forummod.first.created_on.year
            #end
         elsif(type == "Containermod")
            #allContents = Containermod.all
            #if(allContents.count != 0)
               #firstContent = Containermod.first.created_on.year
            #end
         elsif(type == "Maintopicmod")
            #allContents = Maintopicmod.all
            #if(allContents.count != 0)
               #firstContent = Maintopicmod.first.created_on.year
            #end
         elsif(type == "Forummember")
            #allContents = Forummember.all
            #if(allContents.count != 0)
               #firstContent = Forummember.first.created_on.year
            #end
         end

         total = 0
         if(firstContent.to_s != "")
            #Determine if the contents is not bot related
            if(type == "Register")
               nonBot = allContents
            elsif(type != "User")
               nonBot = allContents.select{|content| ((content.user.pouch.privilege != "Bot") && (content.user.pouch.privilege != "Trial")) && ((content.user.pouch.privilege != "Admin") && (content.user.pouch.privilege != "Glitchy"))}
            else
               nonBot = allContents.select{|content| ((content.pouch.privilege != "Bot") && (content.pouch.privilege != "Trial")) && ((content.pouch.privilege != "Admin") && (content.pouch.privilege != "Glitchy"))}
            end

            #Finds all the content created on a specific day
            day = nonBot.select{|content| getTimeDifference(type, content) <= 1.day}
            week = nonBot.select{|content| getTimeDifference(type, content) <= 1.week}
            month = nonBot.select{|content| getTimeDifference(type, content) <= 1.month}
            year = nonBot.select{|content| getTimeDifference(type, content) <= 1.year}
            threeyear = nonBot.select{|content| getTimeDifference(type, content) <= 3.years}
            bacot = nonBot.select{|content| getTimeDifference(type, content) > (firstContent - 1.year)}

            #Sums up the data for the particular timeframe
            dayCount = day.count
            weekCount = week.count - dayCount
            monthCount = month.count - weekCount - dayCount
            yearCount = year.count - monthCount - weekCount - dayCount
            dreiJahreCount = threeyear.count - yearCount - monthCount - weekCount - dayCount
            bacotCount = bacot.count - dreiJahreCount - yearCount - monthCount - weekCount - dayCount

            total = dayCount
            if(timeframe == "Week")
               total = weekCount
            elsif(timeframe == "Month")
               total = monthCount
            elsif(timeframe == "Year")
               total = yearCount
            elsif(timeframe == "Threeyears")
               total = dreiJahreCount
            elsif(timeframe == "BaconOfTomato")
               total = bacotCount
            elsif(timeframe == "All")
               total = nonBot.count
            end
         end
         return total
      end

      def getVisitStats(type, timeframe)
         #Needs to fixed when visits comes in
         allVisits = ""
         if(type == "User")
            #allVisits = Uservisit.all
         elsif(type == "Radio")
            #allVisits = Radiovisit.all
         elsif(type == "Sound")
            #allVisits = Soundvisit.all
         elsif(type == "Gallery")
            #allVisits = Galleryvisit.all
         elsif(type == "Art")
            #allVisits = Artvisit.all
         elsif(type == "Channel")
            #allVisits = Channelvisit.all
         elsif(type == "Movie")
            #allVisits = Movievisit.all
         elsif(type == "Blog")
            #allVisits = Blogvisit.all
         elsif(type == "OC")
            #allVisits = Ocvisit.all
         elsif(type == "Item")
            #allVisits = Itemvisit.all
         elsif(type == "Creature")
            #allVisits = Creaturevisit.all
         end

         total = 0
         if(allVisits.to_s != "")
            #Determine if the visits is not bot related
            nonBot = allVisits.select{|visit| ((visit.from_user.pouch.privilege != "Bot") && (visit.from_user.pouch.privilege != "Trial")) && ((visit.from_user.pouch.privilege != "Admin") && (visit.from_user.pouch.privilege != "Glitchy"))}

            #Finds all the visit created on a specific time
            twenty = nonBot.select{|visit| getStatDifference(type, visit) <= 20.minutes}
            fourty = nonBot.select{|visit| getStatDifference(type, visit) <= 40.minutes}
            sixty = nonBot.select{|visit| getStatDifference(type, visit) <= 1.hour}
            twohours = nonBot.select{|visit| getStatDifference(type, visit) <= 2.hours}
            threehours = nonBot.select{|visit| getStatDifference(type, visit) <= 3.hours}

            #Sums up the data for the particular timeframe
            twentyCount = twenty.count
            fourtyCount = fourty.count - twentyCount
            sixtyCount = sixty.count - fourtyCount - twentyCount
            twohoursCount = twohours.count - sixtyCount - fourtyCount - twentyCount
            threehoursCount = threehours.count - twohoursCount - sixtyCount - fourtyCount - twentyCount

            total = twentyCount
            if(timeframe == "Fourty")
               total = fourtyCount
            elsif(timeframe == "Sixty")
               total = sixtyCount
            elsif(timeframe == "Twohours")
               total = twohoursCount
            elsif(timeframe == "Threehours")
               total = threehoursCount
            elsif(timeframe == "All")
               total = nonBot.count
            end
         end
         return total
      end
end
