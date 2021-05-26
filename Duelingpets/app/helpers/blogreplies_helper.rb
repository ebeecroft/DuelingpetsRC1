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
            value = params.require(:blogreply).permit(:message, :blog_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, userid)
         #Adds the art points to the economy
         newTransaction = Economy.new(params[:economy])
         newTransaction.econtype = "Content"
         newTransaction.content_type = "Blogreply"
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
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
               #allGroups = Bookgroup.order("created_on desc")
               #allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               #@group = allowedGroups
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
                  if(logged_in.pouch.privilege != "Admin")
                     #Removes the content and decrements the owner's pouch
                     cleanup = Fieldcost.find_by_name("Blogreplycleanup")
                     replyFound.user.pouch.amount -= cleanup.amount
                     @pouch = replyFound.user.pouch
                     @pouch.save
                     economyTransaction("Tax", cleanup.amount, replyFound.user_id)
                  end
                  @blogreply.destroy
                  flash[:success] = "Reply was successfully removed."
                  if(logged_in.pouch.privilege == "Admin")
                     redirect_to replies_path
                  else
                     redirect_to user_blog_path(replyFound.blog.user, replyFound.blog)
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
                        newReply = blogFound.replies.new
                        if(type == "create")
                           newReply = blogFound.blogreplies.new(getReplyParams("Reply"))
                           newReply.created_on = currentTime
                           newReply.updated_on = currentTime
                           newReply.user_id = logged_in.id
                        end

                        #Determines the type of bookgroup the user belongs to
                        #allGroups = Bookgroup.order("created_on desc")
                        #allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        #@group = allowedGroups
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
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           replyFound.reviewed = true
                           replyFound.reviewed_on = currentTime
                           updateGallery(artFound.subfolder)

                           #Adds the points to the user's pouch
                           blogreply = Fieldcost.find_by_name("Blogreply")
                           cost = blogreply.amount
                           if(pouchFound.amount - cost >= 0)
                              economyTransaction("Sink", cost, replyFound.user_id)
                              pouchFound.amount -= cost
                              @pouch = pouchFound
                              @pouch.save
                              @blogreply = replyFound
                              @blogreply.save
                              CommunityMailer.content_comments(@blogreply, "Blogreply", "Approved", 10, "None").deliver_now
                           
                              #allWatches = Watch.all
                              #watchers = allWatches.select{|watch| (((watch.watchtype.name == "Arts" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Artsounds" || watch.watchtype.name == "Artmovies")) || (watch.watchtype.name == "Maincontent" || watch.watchtype.name == "All")) && watch.from_user.id != @art.user_id}
                              #if(watchers.count > 0)
                              #   watchers.each do |watch|
                              #      UserMailer.new_art(@art, watch).deliver
                              #   end
                              #end
                              flash[:success] = "Reply was approved."
                           else
                              flash[:error] = "User can't afford the blogreply cost!"
                           end
                        else
                           @blogreply = replyFound
                           CommunityMailer.content_denied(@blogreply, "Blogreply", "Denied", 0, "None").deliver_now
                           flash[:success] = "Reply was denied."
                        end
                        redirect_to blogreplies_review_path
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
