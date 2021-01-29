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

      def blogadPricing(blog)
         #Keeps track of the price
         pricetag = 0

         #Banner Pricing(36000)
         if(!blog.adbannerpurchased && blog.adbanner.to_s != "")
            bannercost = Fieldcost.find_by_name("Banner")
            pricetag -= bannercost.amount
         end

         #Large Image Pricing(24000)
         if(!blog.largeimage1purchased && blog.largeimage1.to_s != "")
            largeimage = Fieldcost.find_by_name("Largeimage")
            pricetag -= largeimage.amount
         end

         if(!blog.largeimage2purchased && blog.largeimage2.to_s != "")
            largeimage = Fieldcost.find_by_name("Largeimage")
            pricetag -= largeimage.amount
         end

         if(!blog.largeimage3purchased && blog.largeimage3.to_s != "")
            largeimage = Fieldcost.find_by_name("Largeimage")
            pricetag -= largeimage.amount
         end

         #Small Image Pricing(10000)
         if(!blog.smallimage1purchased && blog.smallimage1.to_s != "")
            smallimage = Fieldcost.find_by_name("Smallimage")
            pricetag -= smallimage.amount
         end

         if(!blog.smallimage2purchased && blog.smallimage2.to_s != "")
            smallimage = Fieldcost.find_by_name("Smallimage")
            pricetag -= smallimage.amount
         end

         if(!blog.smallimage3purchased && blog.smallimage3.to_s != "")
            smallimage = Fieldcost.find_by_name("Smallimage")
            pricetag -= smallimage.amount
         end

         if(!blog.smallimage4purchased && blog.smallimage4.to_s != "")
            smallimage = Fieldcost.find_by_name("Smallimage")
            pricetag -= smallimage.amount
         end

         if(!blog.smallimage5purchased && blog.smallimage5.to_s != "")
            smallimage = Fieldcost.find_by_name("Smallimage")
            pricetag -= smallimage.amount
         end

         #Music Pricing(500)
         if(!blog.musicpurchased && (blog.ogg.to_s != "" || blog.mp3.to_s != ""))
            musiccost = Fieldcost.find_by_name("MusicAd")
            pricetag -= musiccost.amount
         end
         return pricetag
      end

      def saveCommons(blog, user, type)
         @blog = blog
         @user = user
         if(@blog.save)
            url = "http://www.duelingpets.net/blogs/review"
            ContentMailer.content_review(@blog, "Blog", url).deliver_later(wait: 5.minutes)
            flash[:success] = "#{@blog.user.vname} blog #{@blog.title} was successfully created."
            redirect_to user_blog_path(@user, @blog)
         else
            render "new"
         end
      end

      def approveBlog(blogFound, pointsForBlog, econname)
         #Rememeber to comeback here to set a limit on the amount of points you can add
         blogFound.reviewed = true
         if(pointsForBlog != 0)
            pouch = Pouch.find_by_user_id(blogFound.user_id)
            currentPoints = pouch.amount + pointsForBlog

            #If the amount of points exceeds the maximum pouch limit
            #then set the pouch = pouch limit


            #can't due this because this section is private
            #if(currentPoints < getUpgradeLimit(pouch, "Pouch"))
               pouch.amount += pointsForBlog
            #else
            #   pouch.amount = getUpgradeLimit(pouch, "Pouch")
            #end
            @pouch = pouch
            @pouch.save
         end
         @blog = blogFound
         @blog.save

         if(pointsForBlog != 0)
            #Handles both Economy sources and sinks
            newTransaction = Economy.new(params[:economy])
            newTransaction.econtype = "Content"
            newTransaction.content_type = "Blog"
            if(econname == "Sink")
               newTransaction.name = "Sink"
               newTransaction.amount = pointsForBlog.abs
            elsif(econname == "Source")
               newTransaction.name = "Source"
               newTransaction.amount = pointsForBlog
            end
            newTransaction.user_id = blogFound.user_id
            newTransaction.created_on = currentTime
            @economytransaction = newTransaction
            @economytransaction.save
         end
         ContentMailer.content_approved(@blog, "Blog", pointsForBlog).deliver_later(wait: 5.minutes)

         #allWatches = Watch.all
         #watchers = allWatches.select{|watch| ((((watch.watchtype.name == "Blogs" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Blogsounds" || watch.watchtype.name == "Blogmovies")) || (watch.watchtype.name == "Forumblogs" || watch.watchtype.name == "All"))) && watch.from_user.id != @blog.user_id}
         #if(watchers.count > 0)
             #   watchers.each do |watch|
                    #      UserMailer.new_blog(@blog, watch).deliver
             #   end
         #end
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
                  if(@blog.update_attributes(getBlogParams("Blog")))
                     flash[:success] = "Blog #{@blog.title} was successfully updated."
                     redirect_to user_blog_path(@blog.user, @blog)
                  else
                     render "edit"
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
               @replies = Kaminari.paginate_array(blogReplies).page(getBlogParams("Page")).per(6)
               #stars = @blog.blogstars.count
               #@stars = stars
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == blogFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Eventually consider adding a sink to this
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
                           if(@blog.blogtype.name == "Adblog")
                              pricetag = blogadPricing(@blog)
                              #Determines if we can afford our purchases
                              pouchValue = userFound.pouch.amount + pricetag
                              if(pouchValue < 0)
                                 flash[:error] = "You have insufficient points to pay for all these ads!"
                                 render "new"
                              elsif(@blog.admascot.to_s != "")
                                 flash[:error] = "Mascots can only be used for non Adblogs!"
                                 render "new"
                              else
                                 saveCommons(@blog, @user, "Development")
                              end
                           elsif(@blog.blogtype.name == "Blog")
                              pricetag = blogadPricing(@blog)
                              if(pricetag == 0)
                                 saveCommons(@blog, @user, "Development")
                              else
                                 flash[:error] = "You can't use ads on Blogs!"
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
                           hoard = Dragonhoard.find_by_id(1)
                           pointsForBlog = 0
                           econname = ""
                           errorType = 0
                           if(blogFound.blogtype.name == "Adblog")
                              pricetag = blogadPricing(blogFound)
                              pouchValue = blogFound.user.pouch.amount + pricetag
                              if(pouchValue < 0)
                                 flash[:error] = "Player can't afford the ads!"
                                 errorType = 1
                              else
                                 pricetag = blogadPricing(blogFound)
                                 if(!blogFound.largeimage1purchased && blogFound.largeimage1.to_s != "")
                                    blogFound.largeimage1purchased = true
                                 end
                                 if(!blogFound.largeimage2purchased && blogFound.largeimage2.to_s != "")
                                    blogFound.largeimage2purchased = true
                                 end
                                 if(!blogFound.largeimage3purchased && blogFound.largeimage3.to_s != "")
                                    blogFound.largeimage3purchased = true
                                 end
                                 if(!blogFound.smallimage1purchased && blogFound.smallimage1.to_s != "")
                                    blogFound.smallimage1purchased = true
                                 end
                                 if(!blogFound.smallimage2purchased && blogFound.smallimage2.to_s != "")
                                    blogFound.smallimage2purchased = true
                                 end
                                 if(!blogFound.smallimage3purchased && blogFound.smallimage3.to_s != "")
                                    blogFound.smallimage3purchased = true
                                 end
                                 if(!blogFound.smallimage4purchased && blogFound.smallimage4.to_s != "")
                                    blogFound.smallimage4purchased = true
                                 end
                                 if(!blogFound.smallimage5purchased && blogFound.smallimage5.to_s != "")
                                    blogFound.smallimage5purchased = true
                                 end
                                 if(!blogFound.adbannerpurchased && blogFound.adbanner.to_s != "")
                                    blogFound.adbannerpurchased = true
                                 end
                                 if(!blogFound.musicpurchased && (blogFound.ogg.to_s != "" || blogFound.mp3.to_s != ""))
                                    blogFound.musicpurchased = true
                                 end
                                 if(pricetag < 0)
                                    profit = pricetag.abs * 0.05
                                    hoard.profit += profit

                                    #This transaction sends points to the dragonhoard
                                    newTax = Economy.new(params[:economy])
                                    newTax.name = "Tax"
                                    newTax.econtype = "Treasury"
                                    newTax.content_type = "Blog"
                                    newTax.amount = profit
                                    user = User.find_by_id(8)
                                    newTax.user_id = user.id
                                    newTax.created_on = currentTime
                                    @economytransaction = newTax
                                    @economytransaction.save
                                    @dragonhoard = hoard
                                    @dragonhoard.save
                                    pointsForBlog = pricetag
                                    econname = "Sink"
                                 end
                              end
                           elsif(blogFound.blogtype.name == "Blog")
                              if(!blogFound.pointsreceived)
                                 blogpoints = Fieldcost.find_by_name("Blog")
                                 pointsForBlog = blogpoints.amount
                                 if(blogFound.admascot.to_s != "")
                                    mascotpoints = Fieldcost.find_by_name("Mascot")
                                    pointsForBlog = mascotpoints.amount
                                 end
                                 econname = "Source"
                                 blogFound.pointsreceived = true
                              end
                           end
                           if(errorType != 1)
                              approveBlog(blogFound, pointsForBlog, econname)
                              value = "#{blogFound.user.vname}'s blog #{blogFound.title} was approved."
                           else
                              redirect_to blogs_review
                           end
                        else
                           @blog = blogFound
                           ContentMailer.content_denied(@blog, "Blog").deliver_later(wait: 5.minutes)
                           value = "#{@blog.user.vname}'s blog #{@blog.title} was denied."
                        end
                        flash[:success] = value
                        redirect_to blogs_review_path
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
