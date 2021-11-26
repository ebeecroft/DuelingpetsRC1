module BlogrepliesHelper

   private
      def getReplyParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "ReplyId")
            value = params[:blogreply_id]
         elsif(type == "Reply")
            value = params.require(:blogreply).permit(:message, :blog_id, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def updateBlog(blog)
         blog.updated_on = currentTime
         @blog = blog
         @blog.save
      end
      
      def callMaintenance(type)
         allMode = Maintenancemode.find_by_id(1)
         userMode = Maintenancemode.find_by_id(6)
         if(allMode.maintenance_on || userMode.maintenance_on)
            staff = (current_user && (current_user.pouch.privilege == "Admin" || current_user.pouch.privilge == "Betawriter"))
            if(staff)
               if(type == "new" || type == "create")
                  createCommons(type)
               else
                  editCommons(type)
               end
            else
               if(allMode.maintenance_on)
                  render "/start/maintenance"
               else
                  render "/users/maintenance"
               end
            end
         else
            if(type == "new" || type == "create")
               createCommons(type)
            else
               editCommons(type)
            end
         end
      end
      
      def createCommons(type)
         logged_in = current_user
         blogFound = Blog.find_by_id(getReplyParams("Blog"))
         blogOwner = (logged_in && blogFound && logged_in.id == blogFound.user_id && blogFound.user.gameinfo.startgame)
         commentor = (logged_in && blogFound && logged_in.id != blogFound.user_id && logged_in.gameinfo.startgame)
         price = Fieldcost.find_by_name("Blogreply")
         if(blogOwner && blogFound.user.pouch.amount - price.amount >= 0 || commentor && logged_in.pouch.amount - price.amount >= 0)
            newReply = blogFound.replies.new
            if(type == "create")
               newReply = blogFound.blogreplies.new(getReplyParams("Reply"))
               newReply.created_on = currentTime
               newReply.updated_on = currentTime
               newReply.user_id = logged_in.id
            end

            #Determines the type of bookgroup the user belongs to
            allGroups = Bookgroup.order("created_on desc")
            allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
            @group = allowedGroups
            @blog = blogFound
            @blogreply = newReply
            
            if(type == "create")
               if(@blogreply.save)
                  updateBlog(@blogreply.blog)
                  url = "http://www.duelingpets.net/blogreplies/review"
                  CommunityMailer.content_comments(@blogreply, "Blogreply", "Review", 0, url).deliver_now
                  flash[:success] = "Reply was successfully created."
                  redirect_to user_blog_path(@blog.user, @blog)
               else
                  render "new"
               end
            end
         else
            if(!blogFound)
               flash[:error] = "The blog does not exist!"
            elsif(!logged_in)
               flash[:error] = "Only logged in users can add replies!"
            elsif(!blogFound.user.gameinfo.startgame)
               flash[:error] = "Blog owner #{blogFound.blog.user.vname} has not activated their game yet!"
            elsif(blogFound.user.pouch.amount - price.amount < 0)
               flash[:error] = "Blog owner #{blogFound.blog.user.vname} can't afford the reply price!"
            elsif(!logged_in.gameinfo.startgame)
               flash[:error] = "Commentor #{logged_in.vname} has not activated their game yet!"
            else
               flash[:error] = "Commentor #{logged_in.vname} can't afford the reply price!"
            end
            redirect_to root_path
         end
      end

      def editCommons(type)
         logged_in = current_user
         replyFound = Blogreply.find_by_id(getReplyParams("Id"))
         staff = (logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Betawriter"))
         replyOwner = (replyFound && logged_in && (logged_in.id == replyFound.user_id))
         blogOwner = (replyFound && logged_in && (logged_in.id == replyFound.blog.user_id))
         if(replyFound && (staff || replyOwner || blogOwner))
            replyFound.updated_on = currentTime
            replyFound.reviewed = false
            
            #Determines the type of bookgroup the user belongs to
            allGroups = Bookgroup.order("created_on desc")
            allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
            @group = allowedGroups
            @blogreply = replyFound
            @blog = blog.find_by_id(replyFound.blog.id)
            if(type == "update")
               if(@blogreply.update_attributes(getReplyParams("Reply")))
                  updateBlog(@blog)
                  flash[:success] = "Reply was successfully updated."
                  redirect_to blog_reply_path(@reply.blog, @reply)
               else
                  render "edit"
               end
            elsif(type == "destroy")
               price = Fieldcost.find_by_name("Blogreplycleanup")
               rpOwner = (replyFound.user.gameinfo.startgame && replyFound.user.pouch.amount - price.amount >= 0)
               bpOwner = (replyFound.blog.user.gameinfo.startgame && replyFound.blog.user.pouch.amount - price.amount >= 0)
               if(staff || rpOwner || bpOwner) #XOR operation
                  if(rpOwner)
                     #Might rebalance this
                     replyFound.user.pouch.amount -= price.amount
                     @pouch = replyFound.user.pouch
                     @pouch.save
                     economyTransaction("Sink", price.amount, replyFound.user.id, "Points")
                  elsif(bpOwner)
                     replyFound.blog.user.pouch.amount -= price.amount
                     @pouch = replyFound.blog.user.pouch
                     @pouch.save
                     economyTransaction("Sink", price.amount, replyFound.blog.user.id, "Points")
                  end
                  @blogreply.destroy
                  flash[:success] = "Reply was successfully removed."
                  if(staff)
                     redirect_to replies_path
                  else
                     redirect_to user_blog_path(replyFound.blog.user, replyFound.blog)
                  end
               else
                  if(!replyFound.user.gameinfo.startgame)
                     flash[:error] = "RP owner #{replyFound.user.vname} has not activated their game yet!"
                  elsif(replyFound.user.pouch.amount - price.amount < 0)
                     flash[:error] = "RP owner #{replyFound.user.vname} has insufficient points to remove the reply!"
                  elsif(!replyFound.blog.user.gameinfo.startgame)
                     flash[:error] = "BP owner #{replyFound.blog.user.vname} has not activated their game yet!"
                  else
                     flash[:error] = "BP owner #{replyFound.blog.user.vname} has insufficient points to remove the reply!"
                  end
                  redirec_to root_path
               end
            end
         else
            if(!replyFound)
               flash[:error] = "The reply does not exist!"
            else
               flash[:error] = "User doesn't have permission to edit this reply!"
            end
            redirect_to root_path
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            removeTransactions
            if(type == "index")
               #Staff only
               logged_in = current_user
               staff = (logged_in && (logged_in.pouch.privilege == "Admin" || logged_in.pouch.privilege == "Betawriter"))
               if(staff)
                  allReplies = Blogreply.order("updated_on desc, created_on desc")
                  @blogreplies = Kaminari.paginate_array(allReplies).page(getReplyParams("Page")).per(10)
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create" || type == "edit" || type == "update" || type == "destroy")
               #Login only
               callMaintenance(type)
            elsif(type == "review" || type == "approve" || type == "deny")
               #Staff only
               staff = (current_user && (current_user.pouch.privilege == "Admin" || current_user.pouch.privilege == "Betawriter"))
               if(staff)
                  if(type == "review")
                     allReplies = Blogreply.order("reviewed_on desc, created_on desc")
                     repliesToReview = allReplies.select{|reply| !reply.reviewed}
                     @blogreplies = Kaminari.paginate_array(repliesToReview).page(getReplyParams("Page")).per(10)
                  else
                     replyFound = Blogreply.find_by_id(getReplyParams("ReplyId"))
                     if(replyFound && type == "approve")
                        replyFound.reviewed = true
                        replyFound.reviewed_on = currentTime
                        updateBlog(replyFound.blog)
                        if(replyFound.buildpaid)
                           @blogreply = replyFound
                           @blogreply.save
                           flash[:success] = "#{replyFound.user.vname}'s comment was approved."
                           CommunityMailer.content_comments(@blogreply, "Blogreply", "Approved", 0, "None").deliver_now
                           redirect_to blogreplies_review_path
                        else
                           replyFound.buildpaid = true
                           price = Fieldcost.find_by_name("Blogreply")
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price.amount * rate.amount).round
                           if(replyFound.user.gameinfo.startgame && replyfound.user.pouch.amount - price.amount >= 0)
                              @blogreply = replyFound
                              @blogreply.save
                              
                              #Decrements players points
                              replyFound.user.pouch.amount -= price.amount
                              @pouch = replyFound.user.pouch
                              @pouch.save
                              
                              #Adds points to the central bank
                              hoard = Dragonhoard.find_by_id(1)
                              hoard.profit += tax
                              @hoard = hoard
                              @hoard.save
                              
                              #Displays the results of the transaction
                              economyTransaction("Sink", price.amount - tax, replyFound.user_id, "Points")
                              economyTransaction("Tax", tax, replyFound.user_id, "Points")
                              CommunityMailer.content_comments(@blogreply, "Blogreply", "Approved", price.amount, "None").deliver_now
                              flash[:success] = "#{replyFound.user.vname}'s comment was approved."
                              redirect_to blogreplies_review_path
                           else
                              if(!replyFound.user.gameinfo.startgame)
                                 flash[:error] = "{replyFound.user.vname} has not activated their game yet!"
                              else
                                 flash[:error] = "#{replyFound.user.vname} can't afford the reply buildprice!"
                              end
                              redirect_to blogreplies_review_path
                           end
                        end
                     elsif(replyFound && type == "deny")
                        @blogreply = replyFound
                        CommunityMailer.content_denied(@blogreply, "Blogreply", "Denied", 0, "None").deliver_now
                        flash[:success] = "#{replyFound.user.vname}'s comment was denied."
                        redirect_to blogreplies_review_path
                     else
                        flash[:error] = "Reply does not exist!"
                        redirect_to root_path
                     end
                  end
               else
                  flash[:error] = "This page is restricted to Staff only!"
                  redirect_to root_path
               end
            end
         end
      end
end
