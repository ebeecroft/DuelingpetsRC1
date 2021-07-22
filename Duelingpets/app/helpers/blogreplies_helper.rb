module BlogrepliesHelper

   private
      def getReplyParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "ReplyId")
            value = params[:blogreply_id]
         elsif(type == "Reply")
            #Maybe add bookgroup later?
            value = params.require(:blogreply).permit(:message, :blog_id, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def economyTransaction(type, points, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Communication"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Blogreply"
         newTransaction.econtype = type
         newTransaction.amount = points
         #Currency can be either Points, Emeralds or Skildons
         newTransaction.currency = currency
         if(type != "Tax")
            newTransaction.user_id = userid
         else
            newTransaction.dragonhoard_id = 1
         end
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def updateBlog(blog)
         blog.updated_on = currentTime
         @blog = blog
         @blog.save
      end

      def editCommons(type)
         replyFound = Blogreply.find_by_id(getReplyParams("Id"))
         if(replyFound)
            logged_in = current_user
            if(logged_in && (((logged_in.id == replyFound.user_id) || (logged_in.id == replyFound.blog.user_id)) || logged_in.pouch.privilege == "Admin"))
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
                  cleanup = Fieldcost.find_by_name("Blogreplycleanup")
                  if(replyFound.user.pouch.amount - cleanup.amount >= 0)
                     if(replyFound.user.gameinfo.startgame)
                        #Removes the content and decrements the owner's pouch
                        replyFound.user.pouch.amount -= cleanup.amount
                        @pouch = replyFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup.amount, replyFound.user.id, "Points")
                        flash[:success] = "Reply was successfully removed."
                        @blogreply.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to replies_path
                        else
                           redirect_to user_blog_path(replyFound.blog.user, replyFound.blog)
                        end
                     else
                        if(logged_in.pouch.privilege == "Admin")
                           flash[:error] = "The user has not activated the game yet!"
                           redirect_to replies_path
                        else
                           flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                           redirect_to edit_gameinfo_path(logged_in.gameinfo)
                        end
                     end
                  else
                     flash[:error] = "#{@blogreply.user.vname}'s has insufficient points to remove the reply!"
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to replies_path
                     else
                        redirect_to user_blog_path(replyFound.blog.user, replyFound.blog)
                     end
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allReplies = Blogreply.order("updated_on desc, created_on desc")
                  @blogreplies = Kaminari.paginate_array(allReplies).page(getReplyParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               galleryMode = Maintenancemode.find_by_id(14)
               if(allMode.maintenance_on || galleryMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/galleries/maintenance"
                  end
               else
                  logged_in = current_user
                  blogFound = Blog.find_by_id(getReplyParams("Blog"))
                  if(logged_in && blogFound)
                     if(logged_in.id == blogFound.user_id)
                        if(logged_in.gameinfo.startgame)
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
                           flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                           redirect_to edit_gameinfo_path(logged_in.gameinfo)
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  galleryMode = Maintenancemode.find_by_id(14)
                  if(allMode.maintenance_on || galleryMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/galleries/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allReplies = Blogreply.order("reviewed_on desc, created_on desc")
                  if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                     repliesToReview = allReplies.select{|reply| !reply.reviewed}
                     @blogreplies = Kaminari.paginate_array(repliesToReview).page(getReplyParams("Page")).per(10)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  replyFound = Blogreply.find_by_id(getReplyParams("ReplyId"))
                  if(replyFound)
                     pouchFound = Pouch.find_by_user_id(replyFound.user.id)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           if(replyFound.user.gameinfo.startgame)
                              replyFound.reviewed = true
                              replyFound.reviewed_on = currentTime
                              updateBlog(replyFound.blog)
                              if(!replyFound.purchased)
                                 price = Fieldcost.find_by_name("Blogreply")
                                 rate = Ratecost.find_by_name("Purchaserate")
                                 tax = (price.amount * rate.amount).round
                                 if(pouch.amount - price.amount >= 0)
                                    pouch.amount -= price.amount
                                    @pouch = pouch
                                    @pouch.save
                                    hoard = Dragonhoard.find_by_id(1)
                                    hoard.profit += tax
                                    @hoard = hoard
                                    @hoard.save
                                    economyTransaction("Sink", price.amount - tax, replyFound.user_id, "Points")
                                    economyTransaction("Tax", tax, replyFound.user_id, "Points")
                                    replyFound.purchased = true
                                    @blogreply = replyFound
                                    @blogreply.save
                                    flash[:success] = "#{replyFound.user.vname}'s comment was approved."
                                    CommunityMailer.content_comments(@blogreply, "Blogreply", "Approved", price.amount, "None").deliver_now
                                 else
                                    flash[:error] = "#{replyFound.user.vname}'s funds are too low to create a comment!"
                                 end
                                 redirect_to blogreplies_review_path
                              else
                                 @blogreply = replyFound
                                 @blogreply.save
                                 flash[:success] = "#{replyFound.user.vname}'s comment was approved."
                                 CommunityMailer.content_comments(@blogreply, "Blogreply", "Approved", 0, "None").deliver_now
                                 redirect_to blogreplies_review_path
                              end
                           else
                              flash[:error] = "The user hasn't started the game yet!"
                              redirect_to blogreplies_review_path
                           end
                        else
                           @blogreply = replyFound
                           CommunityMailer.content_denied(@blogreply, "Blogreply", "Denied", 0, "None").deliver_now
                           flash[:success] = "#{replyFound.user.vname}'s comment was denied."
                           redirect_to blogreplies_review_path
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
