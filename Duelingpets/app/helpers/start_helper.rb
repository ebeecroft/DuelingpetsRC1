module StartHelper

   private
      def getStartParams(type)
         value = ""
         if(type == "Name")
            value = params[:session][:name].downcase
         elsif(type == "Color")
            value = params[:session][:color].downcase
         elsif(type == "Email")
            value = params[:session][:email].downcase
         elsif(type == "Subject")
            value = params[:session][:subject]
         elsif(type == "Body")
            value = params[:session][:body]
         elsif(type == "Color")
            value = params[:session][:color].downcase
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
            
      def staff
         value = false
         if(((current_user.pouch.privilege == "Keymaster") || (current_user.pouch.privilege == "Reviewer")) || (current_user.pouch.privilege == "Admin"))
            value = true
         end
         return value
      end

      def boxstatus(type)
         status = ""
         if(type == "Donationbox")
            if(current_user.donationbox.box_open)
               status = "Open"
            else
               status = "Closed"
            end
         elsif(type == "Shoutbox")
            if(current_user.shoutbox.box_open)
               status = "Open"
            else
               status = "Closed"
            end
         elsif(type == "PMbox")
            if(current_user.pmbox.box_open)
               status = "Open"
            else
               status = "Closed"
            end
         end
         return status
      end

      def alert(type)
         value = 0
         if(type != "All")
            if(alertMessages(type, "Number") != 0)
               value += 1
            end
         else
            #Determines if we are running out of storage space
            if(alertMessages("Pouch", "Number") != 0)
               value += 1
            end
            if(alertMessages("Emerald", "Number") != 0)
               value += 1
            end
            if(alertMessages("Blog", "Number") != 0)
               value += 1
            end
            if(alertMessages("OC", "Number") != 0)
               value += 1
            end
            if(alertMessages("Dreyore", "Number") != 0)
               value += 1
            end
            if(alertMessages("Jukebox", "Number") != 0)
               value += 1
            end
            if(alertMessages("Book", "Number") != 0)
               value += 1
            end
            if(alertMessages("Channel", "Number") != 0)
               value += 1
            end
            if(alertMessages("Gallery", "Number") != 0)
               value += 1
            end
            if(alertMessages("Shoutbox", "Number") != 0)
               value += 1
            end
            if(alertMessages("PMbox", "Number") != 0)
               value += 1
            end
            if(alertMessages("Donationbox", "Number") != 0)
               value += 1
            end
            if(alertMessages("Partner", "Number") != 0)
               value += 1
            end
            if(alertMessages("Item", "Number") != 0)
               value += 1
            end
         end
         return value
      end

      def alertMessages(type, valueType)
         alert = 0
         capacity = 0
         amount = 0

         #Determines the message to display
         if(type == "Pouch")
            capacity = getUpgrades("Pouch", "Limit", current_user.pouch, 1)
            amount = current_user.pouch.amount
         elsif(type == "Emerald")
            capacity = getUpgrades("Emerald", "Limit", current_user.pouch, 2)
            amount = current_user.pouch.emeraldamount
         elsif(type == "Blog")
            capacity = getUpgrades("Blog", "Limit", current_user.pouch, 3)
            amount = current_user.blogs.count
         elsif(type == "OC")
            capacity = getUpgrades("OC", "Limit", current_user.pouch, 4)
            amount = current_user.ocs.count
         elsif(type == "Dreyore")
            capacity = getUpgrades("Dreyore", "Limit", current_user.pouch, 5)
            amount = current_user.pouch.dreyterriumamount
         elsif(type == "Jukebox")
            capacity = getUpgrades("Jukebox", "Limit", current_user.pouch, 6)
            amount = current_user.jukeboxes.count
         elsif(type == "Book")
            capacity = getUpgrades("Book", "Limit", current_user.pouch, 7)
            amount = current_user.books.count
         elsif(type == "Channel")
            capacity = getUpgrades("Channel", "Limit", current_user.pouch, 8)
            amount = current_user.channels.count
         elsif(type == "Gallery")
            capacity = getUpgrades("Gallery", "Limit", current_user.pouch, 9)
            amount = current_user.galleries.count
            #End of traditional content
         elsif(type == "Shoutbox")
            capacity = current_user.shoutbox.capacity
            allShouts = Shout.all
            shouts = allShouts.select{|shout| shout.shoutbox_id == current_user.shoutbox.id}
            amount = shouts.count
         elsif(type == "PMbox")
            capacity = current_user.pmbox.capacity
            allPMs = Pm.all
            pms = allPMs.select{|pm| pm.pmbox_id == current_user.pmbox.id}
            amount = pms.count
         elsif(type == "Donationbox")
            capacity = current_user.donationbox.capacity
            amount = current_user.donationbox.progress
         elsif(type == "Partner")
            capacity = current_user.inventory.petcapacity
            amount = current_user.partners.count
         elsif(type == "Item")
            capacity = current_user.inventory.capacity
            amount = current_user.inventory.inventoryslots.count
         end

         #Decides on whether to pass back a string or a number
         if(valueType == "Name")
            if(capacity != 0 && capacity - amount >= 0)
               if(amount == capacity)
                  alert = "Full capacity"
               elsif(capacity - amount <= 4 && amount > 0)
                  alert = "Limited capacity"
               elsif((capacity >= 20 && amount > 0) && ((capacity - amount) <= (capacity * 0.25)))
                  alert = "Quarter capacity"
               end
            elsif(capacity == 0)
               alert = "N/A"
            else
               alert = "Overflow, please delete some!"
            end   
         else
            if(capacity != 0 && capacity - amount >= 0)
               if(amount == capacity)
                  alert = 1
               elsif(capacity - amount <= 4 && amount > 0)
                  alert = 2
               elsif((capacity >= 20 && amount > 0) && ((capacity - amount) <= (capacity * 0.25)))
                  alert = 3
               end
            elsif(capacity == 0)
               alert = 0
            else
               alert = -1
            end
         end
         return alert
      end

      def notify(type)
         #Determines the content that will be chosen
         if(type == "Blog")
            allContents = Blog.all
         elsif(type == "OC")
            allContents = Oc.all
         elsif(type == "Item")
            allContents = Item.all
         elsif(type == "Monster")
            allContents = Monster.all
         elsif(type == "Creature")
            allContents = Creature.all
         elsif(type == "Art")
            allContents = Art.all
         elsif(type == "Sound")
            allContents = Sound.all
         elsif(type == "Movie")
            allContents = Movie.all
         elsif(type == "Chapter")
            allContents = Chapter.all
         elsif(type == "Registration")
            allContents = Registration.all
         elsif(type == "Colorscheme")
            allContents = Colorscheme.all
         elsif(type == "Shout")
            allContents = Shout.all
         elsif(type == "PM")
            allContents = Pm.all
         elsif(type == "Partner")
            allContents = Partner.all
         else
            raise "My invalid type is: #{type}"
         end
         return allContents
      end   

      def getNotifications(type)
         allContents = ""
         value = 0
         if(type != "All")
            allContents = notify(type)
         end

         #Determines which value system to use
         if(type == "Registration")
            contents = allContents
            value = contents.count
         elsif(type == "Colorscheme")
            contents = allContents.select{|content| !content.activated && content.user_id == current_user.id}
            value = contents.count
         elsif(type == "Shout")
            contents = allContents.select{|content| !content.reviewed && content.shoutbox_id == current_user.shoutbox.id}
            value = contents.count
         elsif(type == "PM")
            contents = allContents.select{|content| (content.user_id == current_user.id && content.user1_unread) || (content.pmbox.user_id == current_user.id && content.user2_unread)}
            value = contents.count
         elsif(type == "Partner")
            contents = allContents.select{|content| content.inbattle && content.user_id == current_user.id}
            value = contents.count
         elsif(type == "All")
            noteCount = 0
            if(staff)
               allContents = notify("Blog")
               blogs = allContents.select{|content| !content.reviewed}
               noteCount += blogs.count

               allContents = notify("OC")
               ocs = allContents.select{|content| !content.reviewed}
               noteCount += ocs.count

               allContents = notify("Item")
               items = allContents.select{|content| !content.reviewed}
               noteCount += items.count

               allContents = notify("Creature")
               creatures = allContents.select{|content| !content.reviewed}
               noteCount += creatures.count

               allContents = notify("Art")
               arts = allContents.select{|content| !content.reviewed}
               noteCount += arts.count

               allContents = notify("Sound")
               sounds = allContents.select{|content| !content.reviewed}
               noteCount += sounds.count

               allContents = notify("Movie")
               movies = allContents.select{|content| !content.reviewed}
               noteCount += movies.count

               allContents = notify("Chapter")
               chapters = allContents.select{|content| !content.reviewed}
               noteCount += chapters.count

               allContents = notify("Registration")
               noteCount += allContents.count
            end

            #Counts all the Colorschemes and shout related notifications
            allContents = notify("Colorscheme")
            colors = allContents.select{|content| !content.activated && content.user_id == current_user.id}
            noteCount += colors.count

            allContents = notify("Shout")
            shouts = allContents.select{|content| !content.reviewed && content.shoutbox_id == current_user.shoutbox.id}
            noteCount += shouts.count

            #Counts all the PM and partner related notifications
            allContents = notify("PM")
            pms = allContents.select{|content| (content.user_id == current_user.id && content.user1_unread) || (content.pmbox.user_id == current_user.id && content.user2_unread)}
            noteCount += pms.count

            allContents = notify("Partner")
            partners = allContents.select{|content| content.inbattle && content.user_id == current_user.id}
            noteCount += partners.count
            value = noteCount
         else
            #This is for notifying staff of new content
            if(allContents.count > 0)
               contents = allContents.select{|content| !content.reviewed}
               value = contents.count
            end
         end
         return value
      end

      def homepageAlerts
         value = ""
         criticalMode = Maintenancemode.find_by_id(2)
         betaMode = Maintenancemode.find_by_id(3)
         grandMode = Maintenancemode.find_by_id(4)
         if(criticalMode.maintenance_on)
            value = "[Chipmunks have ran off with the ram]"
         elsif(betaMode.maintenance_on)
            value = "[Beta]"
         elsif(grandMode.maintenance_on)
            value = "[Grand-Opening]"
         end
         return value
      end

      def gateStatus
         control = Webcontrol.find_by_id(1)
         if(control.gate_open)
            value = "Registration is currently open!"
         else
            value = "Registration is currently closed!"
         end
         return value
      end

      def criticalErrors
         value = 0
         criticalMode = Maintenancemode.find_by_id(2)
         if(criticalMode.maintenance_on)
            value = 1
         end
         return value
      end

      def userprofile(type)
         profile = (link_to("Login", login_path)  + " " + link_to("Register", register_path))
         if(type == "User")
            profile = (link_to(current_user.vname, current_user) + " " + link_to("Logout", logout_path, method: "delete"))
         end
         return profile
      end

      def displayType(type)
         control = Webcontrol.find_by_id(1)
         value = ""

         #Displays a given image to the screen
         if(type == "Favicon")
            value = control.favicon_url(:thumb)
         elsif(type == "Mascot")
            value = control.mascot_url(:thumb)
         elsif(type == "Banner")
            value = control.banner_url(:thumb)
         else
            raise "Invalid type of display was detected!"
         end
         return value
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "home" || type == "aboutus" || type == "hubworld" || type == "privacy")
               removeTransactions
               if(type == "aboutus")
                  displayGreeter("Aboutus")
               end
            elsif(type == "contact" || type == "verify" || type == "verify2")
               removeTransactions
               displayGreeter("Aboutus") #Change later
               if(type == "verify")
                  color_value = getStartParams("Color")
                  if(color_value)
                     results = `public/Resources/Code/verification/verify #{color_value}`
                     validMatch = results

                     #Determines if we are looking at a bot or a human
                     if(!validMatch.empty? && results != "Invalid")
                        params[:session][:create] = color_value
                        render "contact2"
                     else
                        flash[:error] = "Person verification failed. Please try again."
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "Invalid color value"
                     redirect_to root_path
                  end
               elsif(type == "verify2")
                  name_value = getStartParams("Name")
                  email_value = getStartParams("Email")
                  subject_value = getStartParams("Subject")
                  body_value = getStartParams("Body")
                  @name = name_value
                  @email = email_value
                  @subject = subject_value
                  @body = body_value
                  if(name_value.empty? || email_value.empty? || subject_value.empty? || body_value.empty?)
                     flash[:error] = "One of the parameters was empty please ensure all are filled in."
                  else
                     flash[:success] = "Your contact info has now been sent."
                     UserMailer.contact(@name, @email, @subject, @body).deliver_now
                  end
                  redirect_to root_path
               end
            elsif(type == "activeusers")
               allMode = Maintenancemode.find_by_id(1)
               if(allMode.maintenance_on)
                  render "/start/maintenance"
               else
                  if(current_user)
                     displayGreeter("Aboutus") #Change later
                     #Retrieving the active users
                     allUsers = Pouch.order("signed_in_at desc")
                     activeUsers = allUsers.select{|pouch| (pouch.activated && !pouch.signed_out_at) && (pouch.last_visited && (currentTime - pouch.last_visited) < 30.minutes)}
                     @pouches = Kaminari.paginate_array(activeUsers).page(getStartParams("Page")).per(50)
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "admincontrols" || type == "keymastercontrols" || type == "reviewercontrols" || type == "managercontrols" || type == "notification" || type == "pagealerts")
               logged_in = current_user
               if(logged_in)
                  
               else
                  redirect_to root_path
               end
            end
         end
      end
end
