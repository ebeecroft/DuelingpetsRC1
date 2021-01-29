class CommunityMailer < ApplicationMailer

   def content_starred(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Sound")
         email = content.sound.user.email
         message = "Your sound #{content.sound.title} was starred by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Art")
         email = content.art.user.email
         message = "Your art #{content.art.title} was starred by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Movie")
         email = content.movie.user.email
         message = "Your movie #{content.movie.title} was starred by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Blog")
         email = content.blog.user.email
         message = "Your blog #{content.blog.title} was starred by #{content.user.vname}. [Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_favorited(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Sound")
         email = content.sound.user.email
         message = "Your sound #{content.sound.title} was favorited by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Art")
         email = content.art.user.email
         message = "Your art #{content.art.title} was favorited by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Movie")
         email = content.movie.user.email
         message = "Your movie #{content.movie.title} was favorited by #{content.user.vname}. [Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def new_posting(content, type, watch)
      websiteMail = "notification@duelingpets.net"
      email = @watch.from_user.email
      message = ""
      if(type == "Blog")
         message = "#{content.user.vname} created a new blog. [Duelingpets]"
      elsif(type == "Forum")
         message = "#{content.user.vname} created a new forum. [Duelingpets]"
      elsif(type == "Art")
         message = "#{content.user.vname} created a new artwork. [Duelingpets]"
      elsif(type == "Sound")
         message = "#{content.user.vname} created a new sound. [Duelingpets]"
      elsif(type == "Movie")
         message = "#{content.user.vname} created a new movie. [Duelingpets]"
      end
      @type = type
      @content = content
      @watch = watch
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_comments(content, type, status, points, url)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(status == "Review")
         email = content.blog.user.email
         message = "#{content.user.vname}'s blogreply is awaiting your review:[Duelingpets]"
      elsif(status == "Approved")
         email = content.user.email
         message = "Your blogreply to #{content.blog.user.vname}'s blog was approved:[Duelingpets]"
      elsif(status == "Denied")
         email = content.user.email
         message = "Your blogreply to #{content.blog.user.vname}'s blog was denied:[Duelingpets]"
      end
      @type = type
      @status = status
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def content_critiqued(content, type, points)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Sound")
         email = content.sound.user.email
         message = "Your sound #{content.sound.title} was critiqued by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Art")
         email = content.art.user.email
         message = "Your art #{content.art.title} was critiqued by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Movie")
         email = content.movie.user.email
         message = "Your movie #{content.movie.title} was critiqued by #{content.user.vname}. [Duelingpets]"
      elsif(type == "Blog")
         email = content.blog.user.email
         message = "Your blog #{content.blog.title} was replied to by #{content.user.vname}. [Duelingpets]"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end

   def friendship(request, type)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Review")
         email = request.to_user.email
         message = "New friendrequest from #{request.from_user.vname} is awaiting your review:[Duelingpets]"
      elsif(type == "Approved")
         email = request.from_user.email
         message = "You are now friends with #{request.to_user.vname}:[Duelingpets]"
      elsif(type == "Denied")
         email = request.from_user.email
         message = "Your friendrequest with #{request.to_user.vname} was denied:[Duelingpets]"
      end
      @type = type
      @request = request
      mail(to: email, from: websiteMail, subject: message)
   end

   def shouts(content, type, url)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Review")
         email = content.shoutbox.user.email
         message = "#{content.user.vname}'s shout is awaiting your review:[Duelingpets]"
      elsif(type == "Approved")
         email = content.user.email
         message = "Your shout to #{content.shoutbox.user.vname}'s shoutbox was approved:[Duelingpets]"
      elsif(type == "Denied")
         email = content.user.email
         message = "Your shout to #{content.shoutbox.user.vname}'s shoutbox was denied:[Duelingpets]"
      end
      @type = type
      @content = content
      @url = url
      mail(to: email, from: websiteMail, subject: message)
   end

   def messaging(content, type, url)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "PM")
         email = content.pmbox.user.email
         message = "#{content.user.vname} sent you a PM. [Duelingpets]"
      elsif(type == "PMreply")
         if(content.user_id == content.pm.user_id)
            email = content.pm.pmbox.user.email
         elsif(content.user_id == content.pm.pmbox.user.id)
            email = content.pm.user.email
         end
         message = "#{content.user.vname} sent you a new PMreply. [Duelingpets]"
      end
      @type = type
      @content = content
      @url = url
      mail(to: email, from: websiteMail, subject: message)
   end

   def donations(content, type, points, taxrate, tax)
      websiteMail = "notification@duelingpets.net"
      email = ""
      message = ""
      if(type == "Goal")
         email = content.donationbox.user.email
         message = "Congratulations you hit your goal of #{content.donationbox.goal} points!"
         @tax = tax
      elsif(type == "Donated")
         email = content.donationbox.user.email
         message = "#{content.user.vname} donated #{points} points to you!"
      elsif(type == "Retrieve")
         email = content.user.email
         message = "Congratulations #{content.user.vname} you just gained #{points} points!"
         @taxrate = taxrate
         @tax = tax
      elsif(type == "Refund")
         email = content.user.email
         message = "#{content.donationbox.user.vname} gave you back your points!"
      end
      @type = type
      @content = content
      @points = points
      mail(to: email, from: websiteMail, subject: message)
   end
end
