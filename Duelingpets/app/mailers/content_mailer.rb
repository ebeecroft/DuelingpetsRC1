class ContentMailer < ApplicationMailer
   def content_created(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Colorscheme")
         email = content.user.email
         message = "Your colorscheme #{content.name} was created:[Duelingpets]"
      elsif(type == "Suggestion")
         email = content.user.email
         message = "Your suggestion #{content.title} was created:[Duelingpets]"
      elsif(type == "Watch")
         email = content.to_user.email
         message = "#{content.from_user.vname} is now watching you:[Duelingpets]"
      elsif(type == "Referral")
         email = content.referred_by.email
         message = "#{content.to_user.vname} was referred by you:[Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_approved(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = content.user.email
      message = ""

      #Main content
      if(type == "Blog")
         message = "Your blog #{content.title} was approved:[Duelingpets]"
      elsif(type == "OC")
         message = "Your oc #{content.name} was approved:[Duelingpets]"
      elsif(type == "Movie")
         message = "Your movie #{content.title} was approved:[Duelingpets]"
      elsif(type == "Art")
         message = "Your art #{content.title} was approved:[Duelingpets]"   
      elsif(type == "Sound")
         message = "Your sound #{content.title} was approved:[Duelingpets]"
      elsif(type == "Chapter")
         message = "Your chapter #{content.title} was approved:[Duelingpets]"
      end

      #Pet content
      if(type == "Element")
         message = "Your element #{content.name} was approved:[Duelingpets]"
      elsif(type == "Creature")
         message = "Your creature #{content.name} was approved:[Duelingpets]"
      elsif(type == "Monster")
         message = "Your monster #{content.name} was approved:[Duelingpets]"
      elsif(type == "Item")
         message = "Your item #{content.name} was approved:[Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_denied(content, type)
      websiteMail = "notification@duelingpets.net"
      email = content.user.email
      message = ""

      #Main content
      if(type == "Blog")
         message = "Your blog #{content.title} was denied:[Duelingpets]"
      elsif(type == "OC")
         message = "Your oc #{content.name} was denied:[Duelingpets]"
      elsif(type == "Movie")
         message = "Your movie #{content.title} was denied:[Duelingpets]"
      elsif(type == "Art")
         message = "Your art #{content.title} was denied:[Duelingpets]"   
      elsif(type == "Sound")
         message = "Your sound #{content.title} was denied:[Duelingpets]"
      elsif(type == "Chapter")
         message = "Your chapter #{content.title} was denied:[Duelingpets]"
      end

      #Pet content
      if(type == "Element")
         message = "Your element #{content.name} was denied:[Duelingpets]"
      elsif(type == "Creature")
         message = "Your creature #{content.name} was denied:[Duelingpets]"
      elsif(type == "Monster")
         message = "Your monster #{content.name} was denied:[Duelingpets]"
      elsif(type == "Item")
         message = "Your item #{content.name} was denied:[Duelingpets]"
      end
      @type = type
      @content = content
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_review(content, type, url)
      message = ""

      #Main content
      if(type == "Blog")
         message = "New blog #{content.title} is awaiting your review:[Duelingpets]"
      elsif(type == "OC")
         message = "New oc #{content.name} is awaiting your review:[Duelingpets]"
      elsif(type == "Movie")
         message = "New movie #{content.title} is awaiting your review:[Duelingpets]"
      elsif(type == "Art")
         message = "New art #{content.title} is awaiting your review:[Duelingpets]"   
      elsif(type == "Sound")
         message = "New sound #{content.title} is awaiting your review:[Duelingpets]"
      elsif(type == "Chapter")
         message = "New chapter #{content.title} is awaiting your review:[Duelingpets]"
      end

      #Pet content
      if(type == "Element")
         message = "New element #{content.name} is awaiting your review:[Duelingpets]"
      elsif(type == "Creature")
         message = "New creature #{content.name} is awaiting your review:[Duelingpets]"
      elsif(type == "Monster")
         message = "New monster #{content.name} is awaiting your review:[Duelingpets]"
      elsif(type == "Item")
         message = "New item #{content.name} is awaiting your review:[Duelingpets]"
      end
      @type = type
      @content = content
      @url = url
      emailStaff(message)
   end

   def emailStaff(message)
      websiteMail = "notification@duelingpets.net"
      allPouches = Pouch.all
      mods = allPouches.select{|pouch| (pouch.privilege == "Keymaster" || pouch.privilege == "Reviewer")}
      if(mods.count > 0)
         mods.each do |staff|
            mail(to: staff.user.email, from: websiteMail, subject: message)
         end
      end
   end
end
