class UserMailer < ApplicationMailer

   def user_info(user, type)
      websiteMail = "notification@duelingpets.net"
      email = user.email
      message = ""
      if(type == "Welcome")
         message = "Welcome #{user.vname}:[Duelingpets]"
      elsif(type == "Resettime")
         message = "Reset time:[Duelingpets]"
      elsif(type == "Resetpassword")
         message = "Reset password:[Duelingpets]"
      elsif(type == "Findlogin")
         message = "Find login:[Duelingpets]"
      elsif(type == "Info")
         message = "Account info:[Duelingpets]"
      end
      @user = user
      @type = type
      mail(to: email, from: websiteMail, subject: message)
   end

   def altEmail(user, email)
      websiteMail = "notification@duelingpets.net"
      message = "Altemail Reset:[Duelingpets]"
      @user = user
      @email = email
      mail(to: email, from: websiteMail, subject: message)
   end

   def contact(name, email, subject, body)
      websiteMail = "notification@duelingpets.net"
      @name = name
      @email = email
      @subject = subject
      @body = body
      mail(to: "contactduelingpets@gmail.com", from: @email, subject: "A new contact was created by #{@name}:[Duelingpets]")
   end

   def login_info(user, password)
      websiteMail = "notification@duelingpets.net"
      @user = user
      @password = password
      mail(to: @user.email, from: websiteMail, subject: "Login info:[Duelingpets]")
   end

   def coppaform(email)
      websiteMail = "notification@duelingpets.net"
      @email = email
      mail(to: @email, from: websiteMail, subject: "Coppaform:[Duelingpets]")
   end

   def registration(content, type, url)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Bot")
         email = "contactduelingpets@gmail.com"
         message = "New bot #{content.vname} was discovered:[Duelingpets]"
      elsif(type == "Review")
         message = "New registration #{content.vname} is awaiting review:[Duelingpets]"
      end
      @content = content
      @url = url
      @type = type
      if(type == "Bot")
         mail(to: email, from: websiteMail, subject: message)
      elsif(type == "Review")
         emailStaff(message)
      end
   end

   def emailStaff(message)
      websiteMail = "notification@duelingpets.net"
      allPouches = Pouch.all
      mods = allPouches.select{|pouch| pouch.privilege == "Keymaster"}
      if(mods.count > 0)
         mods.each do |staff|
            mail(to: staff.user.email, from: websiteEmail, subject: message)
         end
      end
   end
end
