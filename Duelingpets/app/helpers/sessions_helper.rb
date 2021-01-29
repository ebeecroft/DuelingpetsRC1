module SessionsHelper

   private
      def findloginpage(type, pagemode)
         if(type == "findloginpost")
            emailFound = User.find_by_email(params[:session][:email].downcase)
            if(emailFound && emailFound.pouch.activated)
               if(pagemode == "Admin" && emailFound.pouch.privilege == "Admin")
                  retrieveLogin(emailFound)
               elsif(pagemode == "User")
                  retrieveLogin(emailFound)
               else
                  flash.now[:error] = "Only the admin can findlogin at this time."
                  render "recover"
               end
            else
               flash.now[:error] = "Invalid email!"
               render "findemail"
            end
         end
      end
      
      def retrieveLogin(login)
         #Sends the user an email with their login name
         @user = login
         UserMailer.user_info(@user, "Findlogin").deliver_now
         flash[:success] = "Your login was emailed to you!"
         redirect_to root_path
      end
   
      def extendTimelimit(pouch)
         #Extends the time limit for activation
         time_limit = 1.days.from_now.utc
         pouch.remember_token = SecureRandom.urlsafe_base64
         pouch.expiretime = time_limit

         #Emails the user the new activation token
         @pouch = pouch
         @pouch.save
         UserMailer.user_info(@pouch.user, "Resettime").deliver_now
         flash[:success] = "Your time limit was extended and you received a new activation token."
         redirect_to activate_path
      end

      def activateAccount(pouch)
         #Activates the user's account
         pouch.activated = true
         @pouch = pouch
         @pouch.save

         #Emails the user's account the new information
         UserMailer.user_info(@pouch.user, "Info").deliver_now
         flash[:success] = "Your account has now been activated!"
         redirect_to login_path
      end

      def emailUser(loginUser, email)
         #Creates a random new password
         token = SecureRandom.urlsafe_base64
         loginUser.password = token
         loginUser.password_confirmation = token

         #Sends the user an email with their new password
         @user = loginUser
         @user.save

         if(email == "")
            UserMailer.user_info(@user, "Resetpassword").deliver_now
         else
            UserMailer.altEmail(@user, email).deliver_now
         end
         flash[:success] = "Your password was succesfully sent"
         redirect_to root_path
      end

      def createLoginCookie(loginUser, pouch)
         #Display the appropriate message to the user
         message = "Welcome back #{loginUser.vname}"
         if(pouch.signed_in_at == nil)
            message = "Greetings #{loginUser.vname} welcome to Duelingpets"
            UserMailer.user_info(loginUser, "Welcome").deliver_now
         end
         flash[:success] = message

         #Set the user's sign in time to the current time
         pouch.signed_in_at = currentTime
         pouch.last_visited = nil
         pouch.signed_out_at = nil

         #Create the cookie for the current user
         time_limit = 2.days.from_now.utc
         pouch.expiretime = time_limit
         cookie_lifespan = time_limit + 1.month
         pouch.remember_token = SecureRandom.urlsafe_base64
         cookies[:remember_token] = {:value => pouch.remember_token, :expires => cookie_lifespan}

         #Set the current user to the loginUser
         @pouch = pouch
         @pouch.save
         self.current_user = loginUser
         redirect_to loginUser
      end

      def loginpage(type, pagemode)
         if(type == "loginpost")
            loginUser = User.find_by_login_id(params[:session][:login_id].downcase)
            if(loginUser && loginUser.pouch.activated && loginUser.authenticate(params[:session][:password]))
               if(loginUser.pouch.privilege != "Banned")
                  if(pagemode == "Admin" && loginUser.pouch.privilege == "Admin")
                     createLoginCookie(loginUser, loginUser.pouch)
                  elsif(pagemode == "Beta" && loginUser.pouch.privilege != "User")
                     createLoginCookie(loginUser, loginUser.pouch)
                  elsif(pagemode == "User")
                     createLoginCookie(loginUser, loginUser.pouch)
                  else
                     if(pagemode == "Admin")
                        flash.now[:error] = "Only the admin can login at this time."
                        render "login"
                     elsif(pagemode == "Beta")
                        flash.now[:error] = "Only members of the beta class and higher can login."
                        render "login"
                     end
                  end
               else
                  flash.now[:error] = "You have been banned from this site."
                  render "login"
               end
            else
               flash.now[:error] = "Invalid login name/password combination!"
               render "login"
            end
         end
      end

      def recoverpage(type, pagemode)
         if(type == "recoverpost" || type == "altemailpost")
            loginUser = User.find_by_login_id(params[:session][:login_id].downcase)
            vnameUser = User.find_by_vname(params[:session][:vname].downcase)
            email = ""
            if(type == "altemailpost")
               email = (params[:session][:email].downcase)
            end
            if(loginUser && vnameUser && loginUser.pouch.activated && loginUser.id == vnameUser.id)
               if(pagemode == "Admin" && loginUser.pouch.privilege == "Admin")
                  emailUser(loginUser, email)
               elsif(pagemode == "User")
                  emailUser(loginUser, email)
               else
                  flash.now[:error] = "Only the admin can recover at this time."
                  render "recover"
               end
            else
               flash.now[:error] = "Invalid login name/vname combination!"
               render "recover"
            end
         end
      end

      def activatepage(type)
         if(type == "activatepost")
            loginUser = User.find_by_login_id(params[:session][:login_id].downcase)
            token = Pouch.find_by_remember_token(params[:session][:token])
            if(loginUser && token && !loginUser.pouch.activated && loginUser.id == token.id)
               if(currentTime < loginUser.pouch.expiretime)
                  activateAccount(loginUser.pouch)
               else
                  flash.now[:error] = "The time limit has expired for account activation!"
                  render "activate"
               end
            else
               flash.now[:error] = "Invalid login name/token combination!"
               render "activate"
            end
         end
      end

      def extendtimepage(type)
         if(type == "extendtimepost")
            loginUser = User.find_by_login_id(params[:session][:login_id].downcase)
            vnameUser = User.find_by_vname(params[:session][:vname].downcase)
            if(loginUser && vnameUser && !loginUser.pouch.activated && loginUser.id == vnameUser.id)
               if(!loginUser.pouch.activated)
                  extendTimelimit(loginUser.pouch)
               else
                  flash.now[:error] = "This account has already been activated!"
                  render "extendtime"
               end
            else
               flash.now[:error] = "Invalid login name/vname combination!"
               render "extendtime"
            end
         end
      end

      def mode(type)
         if(type == "destroy")
            logout_user
            redirect_to root_path
         elsif(type == "login" || type == "loginpost")
            removeTransactions
            displayGreeter("Login")
            allMode = Maintenancemode.find_by_id(1)
            betaMode = Maintenancemode.find_by_id(3)
            if(allMode.maintenance_on)
               loginpage(type, "Admin")
            elsif(betaMode.maintenance_on)
               loginpage(type, "Beta")
            else
               loginpage(type, "User")
            end
         elsif(type == "recover" || type == "recoverpost")
            removeTransactions
            displayGreeter("Recover")
            allMode = Maintenancemode.find_by_id(1)
            if(allMode.maintenance_on)
               recoverpage(type, "Admin")
            else
               recoverpage(type, "User")
            end
         elsif(type == "altemail" || type == "altemailpost")
            removeTransactions
            displayGreeter("Recover")
            allMode = Maintenancemode.find_by_id(1)
            if(allMode.maintenance_on)
               recoverpage(type, "Admin")
            else
               recoverpage(type, "User")
            end
         elsif(type == "activate" || type == "activatepost")
            removeTransactions
            displayGreeter("Activate")
            allMode = Maintenancemode.find_by_id(1)
            if(allMode.maintenance_on)
               flash.now[:error] = "Account activation is currently offline!"
               render "activate"
            else
               activatepage(type)
            end
         elsif(type == "extendtime" || type == "extendtimepost")
            removeTransactions
            displayGreeter("Reset")
            allMode = Maintenancemode.find_by_id(1)
            if(allMode.maintenance_on)
               flash.now[:error] = "Extending timelimit is currently offline!"
               render "extendtime"
            else
               extendtimepage(type)
            end
         elsif(type == "findlogin" || type == "findloginpost")
            displayGreeter("Reset") #Change to findlogin
            allMode = Maintenancemode.find_by_id(1)
            if(allMode.maintenance_on)
               findloginpage(type, "Admin")
            else
               findloginpage(type, "User")
            end
         end
      end
end
