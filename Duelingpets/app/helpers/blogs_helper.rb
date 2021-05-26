module BlogsHelper

   private
      def getBlogParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "BlogId")
            value = params[:blog_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Blog")
            value = params.require(:blog).permit(:title, :description, :ogg, :remote_ogg_url, :ogg_cache,
            :mp3, :remote_mp3_url, :mp3_cache, :adbanner, :remote_adbanner_url, :adbanner_cache, :admascot,
            :remote_admascot_url, :admascot_cache, :largeimage1, :remote_largeimage1_url, :largeimage1_cache,
            :largeimage2, :remote_largeimage2_url, :largeimage2_cache, :largeimage3, :remote_largeimage3_url,
            :largeimage3_cache, :smallimage1, :remote_smallimage1_url, :smallimage1_cache, :smallimage2,
            :remote_smallimage2_url, :smallimage2_cache, :smallimage3, :remote_smallimage3_url,
            :smallimage3_cache, :smallimage4, :remote_smallimage4_url, :smallimage4_cache, :smallimage5,
            :remote_smallimage5_url, :smallimage5_cache, :bookgroup_id, :blogtype_id, :gviewer_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, userid)
         #Performs a variety of actions depending if it is a blog or an adblog
         newTransaction = Economy.new(params[:economy])
         if(type == "Tax")
            newTransaction.econtype = "Treasury"
         else
            newTransaction.econtype = "Content"
         end
         if(type == "Sink" || type == "Tax")
            newTransaction.content_type = "Adblog"
         else
            newTransaction.content_type = "Blog"
         end
         newTransaction.name = type
         newTransaction.amount = points
         newTransaction.user_id = userid
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userBlogs = userFound.blogs.order("reviewed_on desc, created_on desc")
               blogsReviewed = userBlogs.select{|blog| blog.reviewed || (current_user && blog.user_id == current_user.id)}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allBlogs = Blog.order("reviewed_on desc, created_on desc")
            blogsReviewed = allBlogs.select{|blog| blog.reviewed || (current_user && blog.user_id == current_user.id)}
         end
         @blogs = Kaminari.paginate_array(blogsReviewed).page(getBlogParams("Page")).per(10)
      end

      def optional
         value = getBlogParams("User")
         return value
      end

      def editCommons(type)
         blogFound = Blog.find_by_id(getBlogParams("Id"))
         if(blogFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == blogFound.user_id) || logged_in.pouch.privilege == "Admin"))
               blogFound.updated_on = currentTime
               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups

               #Allows us to choose the type of blog
               blogtypes = Blogtype.order("created_on desc")
               @blogtypes = blogtypes

               #Allows us to select the user who can view the blog
               gviewers = Gviewer.order("created_on desc")
               @gviewers = gviewers

               blogFound.reviewed = false
               @blog = blogFound
               @user = User.find_by_vname(blogFound.user.vname)
               if(type == "update")
                  #Sets up variables to determine if ads were used
                  largeimages = (@blog.largeimage1 != "" || @blog.largeimage2 != "" || @blog.largeimage3 != "")
                  smallimages = (@blog.smallimage1 != "" || @blog.smallimage2 != "" || @blog.smallimage3 != "" || @blog.smallimage4 != "" || @blog.smallimage5 != "")
                  largepurchase = (@blog.largeimage1purchased || @blog.largeimage2purchased || @blog.largeimage3purchased)
                  smallpurchase = (@blog.smallimage1purchased || @blog.smallimage2purchased || @blog.smallimage3purchased || @blog.smallimage4purchased || @blog.smallimage5purchased)
                  purchases = (@blog.adbannerpurchased || largepurchase || smallpurchase || @blog.musicpurchased)
                  adsUsed = (purchases || @blog.adbanner != "" || largeimages || smallimages || (@blog.ogg != "" || @blog.mp3 != ""))
                  if(adsUsed)
                     bannercost = Fieldcost.find_by_name("Banner")
                     largeimage = Fieldcost.find_by_name("Largeimage")
                     smallimage = Fieldcost.find_by_name("Smallimage")
                     musiccost = Fieldcost.find_by_name("MusicAd")
                     price = 0
                     if(@blog.adbanner != "" && !@blog.adbannerpurchased)
                        price += bannercost.amount
                     end
                              
                     #Add large images to the price if one is chosen
                     if(largeimages)
                        if(@blog.largeimage1 != "" && !@blog.largeimage1purchased)
                           price += largeimage.amount
                        end
                        
                        if(@blog.largeimage2 != "" && !@blog.largeimage2purchased)
                           price += largeimage.amount
                        end
                                 
                        if(@blog.largeimage3 != "" && !@blog.largeimage3purchased)
                           price += largeimage.amount
                        end
                     end
                              
                     #Add small images to the price if one is chosen
                     if(smallimages)
                        if(@blog.smallimage1 != "" && !@blog.smallimage1purchased)
                           price += smallimage.amount
                        end
                                 
                        if(@blog.smallimage2 != "" && !@blog.smallimage2purchased)
                           price += smallimage.amount
                        end
                                 
                        if(@blog.smallimage3 != "" && !@blog.smallimage3purchased)
                           price += smallimage.amount
                        end
                                 
                        if(@blog.smallimage4 != "" && !@blog.smallimage4purchased)
                           price += smallimage.amount
                        end
                                 
                        if(@blog.smallimage5 != "" && !@blog.smallimage5purchased)
                           price += smallimage.amount
                        end
                     end
                              
                     #Add music cost to the price if a song is used
                     if((@blog.ogg != "" || @blog.mp3 != "") && !@blog.musicpurchased)
                        price += musiccost.amount
                     end
                              
                     if(@blog.user.pouch.amount - price >= 0)
                        if(@blog.update_attributes(getBlogParams("Blog")))
                           url = "http://www.duelingpets.net/blogs/review"
                           ContentMailer.content_review(@blog, "Blog", url).deliver_later(wait: 5.minutes)
                           flash[:success] = "Blog #{@blog.title} was successfully updated."
                           redirect_to user_blog_path(@blog.user, @blog)
                        else
                           render "edit"
                        end
                     else
                        flash[:error] = "You have insufficient points to pay for all these ads!"
                        redirect_to root_path
                     end
                  else
                     if(@blog.update_attributes(getBlogParams("Blog")))
                        url = "http://www.duelingpets.net/blogs/review"
                        ContentMailer.content_review(@blog, "Blog", url).deliver_later(wait: 5.minutes)
                        flash[:success] = "Blog #{@blog.title} was successfully updated."
                        redirect_to user_blog_path(@blog.user, @blog)
                     else
                        render "edit"
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
      
      def showCommons(type)
         blogFound = Blog.find_by_id(getBlogParams("Id"))
         if(blogFound)
            removeTransactions
            if(blogFound.reviewed || current_user && ((blogFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @blog = blogFound
               blogReplies = @blog.blogreplies.order("created_on desc")
               #Add review later
               replies = blogReplies.select{|blogreply| blogreply.reviewed || (current_user && blogreply.user_id == current_user.id)}
               @replies = Kaminari.paginate_array(replies).page(getBlogParams("Page")).per(6)
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == blogFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     if(logged_in.pouch.privilege != "Admin")
                        #Removes the content and decrements the owner's pouch
                        cleanup = Fieldcost.find_by_name("Blogcleanup")
                        blogFound.user.pouch.amount -= cleanup.amount
                        @pouch = blogFound.user.pouch
                        @pouch.save
                        economyTransaction("Tax", cleanup.amount, blogFound)
                     end
                     @blog.destroy
                     flash[:success] = "#{@blog.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to blogs_list_path
                     else
                        redirect_to user_blogs_path(blogFound.user)
                     end
                  else
                     redirect_to root_path
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
            if(type == "index") #Guests
               removeTransactions
               allMode = Maintenancemode.find_by_id(1)
               blogMode = Maintenancemode.find_by_id(7)
               if(allMode.maintenance_on || blogMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/blogs/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               blogMode = Maintenancemode.find_by_id(7)
               if(allMode.maintenance_on || blogMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/blogs/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getBlogParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newBlog = logged_in.blogs.new
                        if(type == "create")
                           newBlog = logged_in.blogs.new(getBlogParams("Blog"))
                           newBlog.created_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        #Allows us to choose the type of blog
                        blogtypes = Blogtype.order("created_on desc")
                        @blogtypes = blogtypes

                        #Allows us to select the user who can view the blog
                        gviewers = Gviewer.order("created_on desc")
                        @gviewers = gviewers

                        @blog = newBlog
                        @user = userFound

                        if(type == "create")
                           #Sets up variables to determine if ads were used
                           largeimages = (@blog.largeimage1 != "" || @blog.largeimage2 != "" || @blog.largeimage3 != "")
                           smallimages = (@blog.smallimage1 != "" || @blog.smallimage2 != "" || @blog.smallimage3 != "" || @blog.smallimage4 != "" || @blog.smallimage5 != "")
                           adsUsed = (@blog.adbanner != "" || largeimages || smallimages || (@blog.ogg != "" || @blog.mp3 != ""))
                           if(adsUsed)
                              bannercost = Fieldcost.find_by_name("Banner")
                              largeimage = Fieldcost.find_by_name("Largeimage")
                              smallimage = Fieldcost.find_by_name("Smallimage")
                              musiccost = Fieldcost.find_by_name("MusicAd")
                              price = 0
                              if(@blog.adbanner != "")
                                 price += bannercost.amount
                              end
                              
                              #Add large images to the price if one is chosen
                              if(largeimages)
                                 if(@blog.largeimage1 != "")
                                    price += largeimage.amount
                                 end
                                 
                                 if(@blog.largeimage2 != "")
                                    price += largeimage.amount
                                 end
                                 
                                 if(@blog.largeimage3 != "")
                                    price += largeimage.amount
                                 end
                              end
                              
                              #Add small images to the price if one is chosen
                              if(smallimages)
                                 if(@blog.smallimage1 != "")
                                    price += smallimage.amount
                                 end
                                 
                                 if(@blog.smallimage2 != "")
                                    price += smallimage.amount
                                 end
                                 
                                 if(@blog.smallimage3 != "")
                                    price += smallimage.amount
                                 end
                                 
                                 if(@blog.smallimage4 != "")
                                    price += smallimage.amount
                                 end
                                 
                                 if(@blog.smallimage5 != "")
                                    price += smallimage.amount
                                 end
                              end
                              
                              #Add music cost to the price if a song is used
                              if(@blog.ogg != "" || @blog.mp3 != "")
                                 price += musiccost.amount
                              end
                              
                              if(logged_in.pouch.amount - price >= 0)
                                 if(@blog.save)
                                    url = "http://www.duelingpets.net/blogs/review"
                                    ContentMailer.content_review(@blog, "Blog", url).deliver_later(wait: 5.minutes)
                                    flash[:success] = "#{@blog.user.vname} blog #{@blog.title} was successfully created."
                                    redirect_to user_blog_path(@user, @blog)
                                 else
                                    render "new"
                                 end
                              else
                                 flash[:error] = "You have insufficient points to pay for all these ads!"
                                 redirect_to root_path
                              end
                           else
                              if(@blog.save)
                                 url = "http://www.duelingpets.net/blogs/review"
                                 ContentMailer.content_review(@blog, "Blog", url).deliver_later(wait: 5.minutes)
                                 flash[:success] = "#{@blog.user.vname} blog #{@blog.title} was successfully created."
                                 redirect_to user_blog_path(@user, @blog)
                              else
                                 render "new"
                              end
                           end
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  blogMode = Maintenancemode.find_by_id(7)
                  if(allMode.maintenance_on || blogMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/blogs/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               blogMode = Maintenancemode.find_by_id(7)
               if(allMode.maintenance_on || blogMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/blogs/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allBlogs = Blog.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        blogsToReview = allBlogs.select{|blog| !blog.reviewed}
                        @blogs = Kaminari.paginate_array(blogsToReview).page(getBlogParams("Page")).per(4)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @blogs = allBlogs.page(getBlogParams("Page")).per(4)
                     else
                        redirect_to root_path
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  blogFound = Blog.find_by_id(getBlogParams("BlogId"))
                  if(blogFound)
                     removeTransactions
                     value = ""
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        blogFound.reviewed_on = currentTime
                        if(type == "approve")
                           #Sets up variables to determine if ads were used
                           largeimages = (blogFound.largeimage1 != "" || blogFound.largeimage2 != "" || blogFound.largeimage3 != "")
                           smallimages = (blogFound.smallimage1 != "" || blogFound.smallimage2 != "" || blogFound.smallimage3 != "" || blogFound.smallimage4 != "" || blogFound.smallimage5 != "")
                           largepurchase = (blogFound.largeimage1purchased || blogFound.largeimage2purchased || blogFound.largeimage3purchased)
                           smallpurchase = (blogFound.smallimage1purchased || blogFound.smallimage2purchased || blogFound.smallimage3purchased || blogFound.smallimage4purchased || blogFound.smallimage5purchased)
                           purchases = (blogFound.adbannerpurchased || largepurchase || smallpurchase || blogFound.musicpurchased)
                           adsUsed = (purchases || blogFound.adbanner != "" || largeimages || smallimages || (blogFound.ogg != "" || blogFound.mp3 != ""))
                           if(adsUsed)
                              #Might set a flag for adblog here instead of a seperate table!
                              bannercost = Fieldcost.find_by_name("Banner")
                              largeimage = Fieldcost.find_by_name("Largeimage")
                              smallimage = Fieldcost.find_by_name("Smallimage")
                              musiccost = Fieldcost.find_by_name("MusicAd")
                              price = 0
                              if(blogFound.adbanner != "" && !blogFound.adbannerpurchased)
                                 blogFound.adbannerpurchased = true
                                 price += bannercost.amount
                              end
                              
                              #Add large images to the price if one is chosen
                              if(largeimages)
                                 if(blogFound.largeimage1 != "" && !blogFound.largeimage1purchased)
                                    blogFound.largeimage1purchased = true
                                    price += largeimage.amount
                                 end
                        
                                 if(blogFound.largeimage2 != "" && !blogFound.largeimage2purchased)
                                    blogFound.largeimage2purchased = true
                                    price += largeimage.amount
                                 end
                                 
                                 if(blogFound.largeimage3 != "" && !blogFound.largeimage3purchased)
                                    blogFound.largeimage3purchased = true
                                    price += largeimage.amount
                                 end
                              end
                              
                              #Add small images to the price if one is chosen
                              if(smallimages)
                                 if(blogFound.smallimage1 != "" && !blogFound.smallimage1purchased)
                                    blogFound.smallimage1purchased = true
                                    price += smallimage.amount
                                 end
                                 
                                 if(blogFound.smallimage2 != "" && !blogFound.smallimage2purchased)
                                    blogFound.smallimage2purchased = true
                                    price += smallimage.amount
                                 end
                                 
                                 if(blogFound.smallimage3 != "" && !blogFound.smallimage3purchased)
                                    blogFound.smallimage3purchased = true
                                    price += smallimage.amount
                                 end
                                 
                                 if(blogFound.smallimage4 != "" && !blogFound.smallimage4purchased)
                                    blogFound.smallimage4purchased = true
                                    price += smallimage.amount
                                 end
                                 
                                 if(blogFound.smallimage5 != "" && !blogFound.smallimage5purchased)
                                    blogFound.smallimage5purchased = true
                                    price += smallimage.amount
                                 end
                              end
                              
                              #Add music cost to the price if a song is used
                              if((blogFound.ogg != "" || blogFound.mp3 != "") && !blogFound.musicpurchased)
                                 blogFound.musicpurchased = true
                                 price += musiccost.amount
                              end
                              
                              #Decrements the player's pouch for each ad that has not yet been purchased
                              if(blogFound.user.pouch.amount - price >= 0)
                                 blogFound.reviewed = true
                                 @blog = blogFound
                                 if(@blog.save)
                                    @blog.user.pouch.amount -= price
                                    @pouch = @blog.user.pouch
                                    @pouch.save
                                    #This will need to be fixed up and changed
                                    ContentMailer.content_approved(@blog, "Blog", price).deliver_later(wait: 5.minutes)
                                    #Might add a secondary economy transaction here for taxes here on top of the default sink
                                    #used for the dragonhoard collecting points. Tax of 0.05
                                    #Remember econtype is Treasurey, and content type is adblog, name is tax
                                    #econame is sink
                                    #Owner for that is glitchy, plus hoard would go here as well
                                    economyTransaction("Sink", price, @blog.user.id)
                                    flash[:success] = "#{blogFound.user.vname}'s adblog #{blogFound.title} was approved."
                                    redirect_to blogs_review_path
                                 else
                                    flash[:error] = "Unable to save the current blog!"
                                    redirect_to root_path
                                 end
                              else
                                 flash[:error] = "Blog owner can't afford the bought ads!"
                                 redirect_to root_path
                              end
                           else
                              blogFound.reviewed = true
                              points = 0
                              #Award points for first time blogs
                              if(!blogFound.pointsreceived)
                                 if(blogFound.admascot != "")
                                    mascot = Fieldcost.find_by_name("Mascot")
                                    points = mascot.amount
                                 else
                                    blog = Fieldcost.find_by_name("Blog")
                                    points = blog.amount
                                 end
                                 blogFound.user.pouch.amount += points
                                 @pouch = blogFound.user.pouch
                                 @pouch.save
                                 blogFound.pointsreceived = true
                              end
                              @blog = blogFound
                              @blog.save
                              ContentMailer.content_approved(@blog, "Blog", points).deliver_later(wait: 5.minutes)
                              economyTransaction("Source", points, @blog.user.id)
                              flash[:success] = "#{blogFound.user.vname}'s blog #{blogFound.title} was approved."
                              redirect_to blogs_review_path
                              #Come back to this later.
                              #if points + blog > max then set it equal to max
                           end
                        else
                           @blog = blogFound
                           ContentMailer.content_denied(@blog, "Blog").deliver_later(wait: 5.minutes)
                           flash[:success] = "#{@blog.user.vname}'s blog #{@blog.title} was denied."
                           redirect_to blogs_review_path
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
