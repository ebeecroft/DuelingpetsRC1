class ForumMailer < ApplicationMailer

   websiteMail = "notification@duelingpets.net"
   def moderator_review(request, type)
      email = ""
      message = ""
      if(type == "Forum")
         email = request.forum.user.email
         message = "#{request.user.vname}'s forummoderatorrequest is awaiting your review. [Duelingpets]"
      elsif(type == "Container")
         email = request.topiccontainer.forum.user.email
         message = "#{request.user.vname}'s containermoderatorrequest is awaiting your review. [Duelingpets]"
      elsif(type == "Maintopic")
         email = request.maintopic.topiccontainer.forum.user.email
         message = "#{request.user.vname}'s maintopicmoderatorrequest is awaiting your review. [Duelingpets]"
      elsif(type == "Invite")
         #This section is for making people members of an invite only forum
         email = request.to_user.email
         message = "#{request.from_user.vname}'s foruminvite is awaiting your review. [Duelingpets]"
      end
      @type = type
      @request = request
      mail(to: email, from: websiteMail, subject: message)
   end

   def moderator_approved(request, type)
      email = ""
      message = ""
      if(type == "Forum")
         email = request.user.email
         message = "Congratulations #{request.user.vname} your now a forummoderator of the forum #{request.forum.name}. [Duelingpets]"
      elsif(type == "Container")
         email = request.user.email
         message = "Congratulations #{request.user.vname} your now a containermoderator of the topiccontainer #{request.topiccontainer.title}. [Duelingpets]"
      elsif(type == "Maintopic")
         email = request.user.email
         message = "Congratulations #{request.user.vname} your now a maintopicmoderator of the maintopic #{request.maintopic.title}. [Duelingpets]"
      elsif(type == "Invite")
         #This section is for making people members of an invite only forum
         email = request.forum.user.email
         message = "#{request.user.vname} has became a new member of your #{request.forum.name} forum. [Duelingpets]"
      end
      @type = type
      @request = request
      mail(to: email, from: websiteMail, subject: message)
   end

   def moderator_denied(request, type)
      email = ""
      message = ""
      if(type == "Forum")
         email = request.user.email
         message = "Your forummoderatorrequest to the forum #{request.forum.name} was denied. [Duelingpets]"
      elsif(type == "Container")
         email = request.user.email
         message = "Your containermoderatorrequest to the topiccontainer #{request.topiccontainer.title} was denied. [Duelingpets]"
      elsif(type == "Maintopic")
         email = request.user.email
         message = "Your maintopicmoderatorrequest to the maintopic #{request.maintopic.title} was denied. [Duelingpets]"
      elsif(type == "Invite")
         #This section is for making people members of an invite only forum
         email = request.from_user.email
         message = "Your foruminvite to #{request.to_user.vname} was denied. [Duelingpets]"
      end
      @type = type
      @request = request
      mail(to: email, from: websiteMail, subject: message)
   end

   def subscription(content, type, subscriber)
      email = ""
      message = ""
      if(type == "Maintopic")
         email = subscriber.user.email
         message = "#{content.user.vname} has created a new maintopic. [Duelingpets]"
      elsif(type == "Subtopic")
         email = subscriber.user.email
         message = "#{content.user.vname} has created a new subtopic. [Duelingpets]"
      elsif(type == "Narrative")
         email = subscriber.user.email
         message = "#{content.user.vname} has created a new narrative. [Duelingpets]"
      end
      @type = type
      @content = content
      @subscriber = subscriber
      mail(to: email, from: websiteMail, subject: message)
   end

   def forum_ownership(content, type)
      email = ""
      message = ""
      if(type == "Successor")
         email = content.to_user.email
         message = "#{content.to_user.vname} you are now the new forum owner of #{content.forum.name} forum. [Duelingpets]"
      elsif(type == "Takecontrol")
         email = content.pastowner.email
         message = "#{content.pastowner.vname} your forum #{content.forum.name} was taken over by #{content.to_user.vname}. [Duelingpets]"
      end
      @type = type
      @content = content
      mail(to: email, from: websiteMail, subject: message)
   end
end
