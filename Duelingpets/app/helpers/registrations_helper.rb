module RegistrationsHelper

   private
      def getRegistrationParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Registration")
            value = params.require(:registration).permit(:imaginaryfriend, :email, :country, 
            :country_timezone, :birthday, :login_id, :vname, :shared, :message)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
            
      def gateStatus(webcontrol)
         value  = "Closed"
         if(webcontrol.gate_open)
            value = "Open"
         end
         return value
      end
      
      def gateValue
         webcontrol = Webcontrol.find_by_id(1)
         value = ""
         if(webcontrol.gate_open)
            value = "Close-gate"
         else
            value = "Open-gate"
         end
         return value
      end

      def getAge(month, year)
         age = (currentTime.year - year.to_i)
         month = (currentTime.month - month.to_i) / 12
         if(month < 0)
            age -= 1
         end
         return age
      end

      def validateRegistration(registration)
         #Blacklist variables
         names = Blacklistedname.all
         domains = Blacklisteddomain.all
         users = User.all
         name, domain = registration.email.split("@")
         matchType = "None"
         valid = true

         #Checks to see if there is any matches
         firstnameMatch = names.select{|blacklistname| blacklistname.name.downcase == registration.firstname.downcase}
         lastnameMatch = names.select{|blacklistname| blacklistname.name.downcase == registration.lastname.downcase}
         loginMatch = names.select{|blacklistname| blacklistname.name.downcase == registration.login_id.downcase}
         vnameMatch = names.select{|blacklistname| blacklistname.name.downcase == registration.vname.downcase}
         domainMatch = domains.select{|blacklistdomain| blacklistdomain.name.downcase == domain.downcase && blacklistdomain.domain_only}

         userMatch = users.select{|user| user.vname == registration.vname || user.login_id == registration.login_id}
         if(userMatch.count != 0)
            flash.now[:error] = "This vname or login id is already in use. Please choose another!"
            valid = false
         end

         #Determines if this is a domain match or an email match
         if(domainMatch.count != 0)
            matchType = "Domain"
         else
            nameMatch = names.select{|blacklistname| blacklistname.name.downcase == name.downcase}
            domainMatch = domains.select{|blacklistdomain| blacklistdomain.name.downcase == domain.downcase && !blacklistdomain.domain_only}
            if(nameMatch.count != 0 && domainMatch.count != 0)
               matchType = "Email"
            end
         end

         #Displays the error messages for invalid registrations
         if(firstnameMatch.count != 0)
            flash.now[:firstnameerror] = "The firstname #{registration.firstname} is blacklisted!"
            valid = false
         end
         if(lastnameMatch.count != 0)
            flash.now[:lastnameerror] = "The lastname #{registration.lastname} is blacklisted!"
            valid = false
         end
         if(loginMatch.count != 0)
            flash.now[:loginerror] = "The login name #{registration.login_id} is blacklisted!"
            valid = false
         end
         if(vnameMatch.count != 0)
            flash.now[:vnameerror] = "The virtual name #{registration.vname} is blacklisted!"
            valid = false
         end
         if(matchType == "Domain")
            flash.now[:error] = "The domain #{domain} is blacklisted!"
            valid = false
         elsif(matchType == "Email")
            flash.now[:error] = "The email #{registration.email} is blacklisted!"
            valid = false
         end
         return valid
      end

      def welcomeUser
         #Inform users of new user
         blogger = User.find_by_id(2)
         newBlog = blogger.blogs.new(params[:blog])
         newBlog.title = "Let-us-welcome-#{@user.vname}-our-newest-member!"
         newBlog.description = "Welcome #{@user.vname} to the Duelingpets virtual pet site. I hope you enjoy your stay here and make many new friends. The older members of this site will teach you the ropes of the system. #{@user.vname} joined our site on #{@user.joined_on.strftime("%B-%d-%Y")}. So please give a round of applause to our newest member."
         newBlog.blogtype_id = 1
         newBlog.bookgroup_id = 1
         newBlog.blogviewer_id = 1
         newBlog.created_on = currentTime
         newBlog.reviewed_on = currentTime
         newBlog.updated_on = currentTime
         newBlog.reviewed = true
         newBlog.pointsreceived = true
         @blog = newBlog
         @blog.save

         #Reward blogger for new member
         bloggerPouch = Pouch.find_by_user_id(blogger.id)
         blogpoints = Fieldcost.find_by_name("Blog")
         pointsForBlog = blogpoints.amount
         bloggerPouch.amount += pointsForBlog

         #Updated the economy
         newEconomy = Economy.new(params[:economy])
         newEconomy.econtype = "Content"
         newEconomy.content_type = "Blog"
         newEconomy.name = "Source"
         newEconomy.amount = pointsForBlog
         newEconomy.user_id = newBlog.user_id
         newEconomy.created_on = currentTime
         @economy = newEconomy
         @economy.save

         #Save the pouch
         @pouch2 = bloggerPouch
         @pouch2.save
      end

      def buildPouch(user)
         #Builds the user's pouch
         starterPoints = 0
         newPouch = Pouch.new(params[:pouch])
         newPouch.user_id = user.id
         newPouch.remember_token = SecureRandom.urlsafe_base64
         newPouch.amount = starterPoints
         betaMode = Maintenancemode.find_by_id(3)
         if(betaMode.maintenance_on)
            newPouch.privilege = "Beta"
         end

         #Remove some Dreyterrium to give to the user
         dreyore = Dreyore.find_by_name("Newbie")
         dreyore.cur -= 10
         @dreyore = dreyore
         @dreyore.save
         newPouch.dreyterriumamount = 10

         #Save the pouch
         timeout = 1.day.from_now.utc
         newPouch.expiretime = timeout
         @pouch = newPouch
         @pouch.save

         #Builds the pouchslots
         newPouchslot = Pouchslot.new(params[:pouchslot])
         newPouchslot.pouch_id = @pouch.id
         newPouchslot.pouchtype1_id = 2
         newPouchslot.pouchtype2_id = 3
         newPouchslot.pouchtype3_id = 4
         newPouchslot.pouchtype4_id = 5
         newPouchslot.pouchtype5_id = 6
         newPouchslot.pouchtype6_id = 7
         newPouchslot.pouchtype7_id = 8
         newPouchslot.pouchtype8_id = 9
         newPouchslot.pouchtype9_id = 10
         @pouchslot = newPouchslot
         @pouchslot.save
      end

      def buildUserParameters(user, type)
         userstat = ""
         if(type == "Info")
            userstat = Userinfo.new(params[:userinfo])
            userstat.audiobrowser = "ogg"
            userstat.videobrowser = "ogv"
            userstat.info = "Welcome #{user.vname} to Duelingpets!"
            userstat.daycolor_id = 1
            userstat.nightcolor_id = 2
            userstat.bookgroup_id = 1
         elsif(type == "Shoutbox" || type == "PMbox")
            userstat = Shoutbox.new(params[:shoutbox])
            userstat.capacity = 600
            if(type == "PMbox")
               userstat = Pmbox.new(params[:pmbox])
               userstat.capacity = 8000
            end
         elsif(type == "Inventory")
            userstat = Inventory.new(params[:inventory])
         elsif(type == "Donationbox")
            userstat = Donationbox.new(params[:donationbox])
            userstat.initialized_on = currentTime
            userstat.description = "Describe your donation"
            userstat.capacity = 2000000
            userstat.goal = 100
         end
         userstat.user_id = user.id
         @userstat = userstat
         @userstat.save
      end

      def createUser(registrationFound)
         #Builds the user from the registration
         newUser = User.new(params[:user])
         newUser.joined_on = currentTime
         newUser.registered_on = registrationFound.registered_on
         newUser.imaginaryfriend = registrationFound.imaginaryfriend
         newUser.email = registrationFound.email
         newUser.vname = registrationFound.vname
         newUser.login_id = registrationFound.login_id
         newUser.country = registrationFound.country
         newUser.country_timezone = registrationFound.country_timezone
         newUser.birthday = registrationFound.birthday
         newUser.shared = registrationFound.shared
         initialPassword = "Peaches"
         newUser.password = initialPassword
         newUser.password_confirmation = initialPassword
         return newUser
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               logged_in = current_user
               if(logged_in && ((logged_in.pouch.privilege == "Admin") || (logged_in.pouch.privilege == "Keymaster")))
                  removeTransactions
                  allRegistrations = Registration.order("registered_on desc").page(getRegistrationParams("Page")).per(10)
                  @registrations = allRegistrations
               else
                  redirect_to root_path
               end
            elsif(type == "register" || type == "verify" || type == "register2" || type == "create" || type == "emailpost")
               displayGreeter("Register")
               webcontrol = Webcontrol.find_by_id(1)
               if(webcontrol.gate_open)
                  if(type == "verify")
                     #Sets up the user variables
                     color_value = params[:session][:color].downcase
                     month = params[:session][:month]
                     year = params[:session][:year]
                     validDate = (month && year && month.to_i > 0 && month.to_i < 13)
                     if(color_value && validDate)
                        results = `public/Resources/Code/verification/verify #{color_value}`
                        validMatch = results
                        
                        #Determines if we are looking at a bot or a human
                        if(!validMatch.empty? && results != "Invalid")
                           age = getAge(month, year)
                           if(age > 12)
                              @registration = Registration.new
                              render "register2"
                           elsif(age > 6)
                              render "register3"
                           else
                              flash[:error] = "This child is too young to use the site!"
                              redirect_to root_path
                           end
                        else
                           flash[:error] = "User verification failed. Please try again."
                           redirect_to root_path
                        end
                     else
                        flash[:error] = "Invalid color value or date values!"
                        redirect_to root_path
                     end
                  elsif(type == "emailpost")
                     email = params[:session][:parentemail]
                     UserMailer.coppaform(email).deliver_now
                     flash[:success] = "A consent form was sent to your parent's email!"
                     redirect_to root_path
                  elsif(type == "register2" || type == "create")
                     newRegistration = Registration.new
                     if(type == "create")
                        newRegistration = Registration.new(getRegistrationParams("Registration"))
                        newRegistration.registered_on = currentTime
                     end
                     @registration = newRegistration
                     if(type == "create")
                        if(validateRegistration(newRegistration))
                           if(@registration.save)
                              flash[:success] = "Thank you for registration we will review your account over 
                              the next three days to see if it is legitimate."
                              url = "http://www.duelingpets.net/registrations/review"
                              UserMailer.registration(@registration, "Review", url).deliver_later(wait: 2.minutes)
                              redirect_to root_path
                           else
                              render "register2"
                           end
                        else
                           @registration = newRegistration
                           render "register2"
                        end
                     end
                  end
               else
                  flash[:error] = "Registration is currently closed!"
                  redirect_to root_path
               end
            elsif(type == "tokenfinder" || type == "tokenpost")
               webcontrol = Webcontrol.find_by_id(1)
               if(webcontrol.gate_open)
                  if(type == "tokenpost")
                     displayGreeter("Register")
                     token = params[:session][:regtoken]
                     tokenFound = Regtoken.find_by_token(token)
                     if(tokenFound)
                        @registration = Registration.new
                        render "register2"
                     else
                        flash[:error] = "This token is invalid or expired!"
                        redirect_to root_path
                     end
                  end
               else
                  flash[:error] = "Registration is currently closed!"
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  registrationFound = Registration.find_by_id(getRegistrationParams("Id"))
                  if(registrationFound)
                     if(logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Keymaster")
                        @registration = registrationFound
                        if(type == "approve")
                           dreyore = Dreyore.find_by_name("Newbie")
                           if((dreyore.cur - dreyore.baseinc) >= 0)
                              newUser = createUser(registrationFound)
                              @user = newUser
                              if(@user.save)
                                 #Builds the user parameters
                                 buildUserParameters(@user, "Info")
                                 buildUserParameters(@user, "Shoutbox")
                                 buildUserParameters(@user, "PMbox")
                                 buildUserParameters(@user, "Inventory")
                                 buildUserParameters(@user, "Donationbox")
                                 buildPouch(@user)

                                 UserMailer.login_info(@user, @user.password).deliver_later(wait: 2.minutes)
                                 welcomeUser
                                 flash[:success] = "Registration was converted to a user."
                                 @registration.destroy
                              else
                                 flash[:error] = "Registration failed."
                              end
                           else
                              flash[:error] = "Dreyore in reserve is too low to approve registration!"
                           end
                        else
                           url = "BotFound"
                           UserMailer.registration(@registration, "Bot", url).deliver_later(wait: 2.minutes)
                           flash[:success] = "Registration was found to be a bot and was deleted."
                           @registration.destroy
                        end
                        redirect_to registrations_path
                     else
                        redirect_to root_path
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "gate")
               logged_in = current_user
               if(logged_in && ((logged_in.pouch.privilege == "Admin") || (logged_in.pouch.privilege == "Keymaster")))
                  webcontrol = Webcontrol.find_by_id(1)
                  if(webcontrol.gate_open)
                     webcontrol.gate_open = false
                  else
                     webcontrol.gate_open = true
                  end
                  @webcontrol = webcontrol
                  @webcontrol.save
                  flash[:success] = "Gate status has now been set to #{gateStatus(@webcontrol)}"
                  if(logged_in.pouch.privilege == "Admin")
                     redirect_to admincontrols_path
                  elsif(logged_in.pouch.privilege == "Keymaster")
                     redirect_to keymastercontrols_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end     
end
