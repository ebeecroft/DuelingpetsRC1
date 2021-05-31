module OcsHelper

   private
      def getOcParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "OcId")
            value = params[:oc_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Oc")
            value = params.require(:oc).permit(:name, :description, :nickname, :species, :age, :personality, :likesanddislikes, :backgroundandhistory, :relatives, :family, :friends, :world, :alignment, :alliance, :elements, :appearance, :clothing, :accessories, :image, :remote_image_url, :image_cache, :ogg, :remote_ogg_url, :ogg_cache,
            :mp3, :remote_mp3_url, :mp3_cache, :voiceogg, :remote_voiceogg_url, :voiceogg_cache, :voicemp3, :remote_voicemp3_url, :voicemp3_cache,
            :bookgroup_id, :gviewer_id)
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
         newTransaction.content_type = "OC"
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
               userOCs = userFound.ocs.order("reviewed_on desc, created_on desc")
               ocsReviewed = userOCs.select{|oc| (current_user && oc.user_id == current_user.id) || (oc.reviewed && checkBookgroupStatus(oc))}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allOCs = Oc.order("reviewed_on desc, created_on desc")
            ocsReviewed = allOCs.select{|oc| (current_user && oc.user_id == current_user.id) || (oc.reviewed && checkBookgroupStatus(oc))}
         end
         @ocs = Kaminari.paginate_array(ocsReviewed).page(getOcParams("Page")).per(10)
      end

      def optional
         value = getOcParams("User")
         return value
      end

      def editCommons(type)
         ocFound = Oc.find_by_id(getOcParams("Id"))
         if(ocFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == ocFound.user_id) || logged_in.pouch.privilege == "Admin"))
               ocFound.updated_on = currentTime
               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               #Allows us to select the user who can view the oc
               gviewers = Gviewer.order("created_on desc")
               @gviewers = gviewers
               ocFound.reviewed = false
               @oc = ocFound
               @user = User.find_by_vname(ocFound.user.vname)
               if(type == "update")
                  if(@oc.update_attributes(getOcParams("Oc")))
                     flash[:success] = "OC #{@oc.name} was successfully updated."
                     redirect_to user_oc_path(@oc.user, @oc)
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
         ocFound = Oc.find_by_id(getOcParams("Id"))
         if(ocFound)
            removeTransactions
            if(ocFound.reviewed || current_user && ((ocFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @oc = ocFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == ocFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     if(logged_in.pouch.privilege != "Admin")
                        #Removes the content and decrements the owner's pouch
                        cleanup = Fieldcost.find_by_name("OCcleanup")
                        ocFound.user.pouch.amount -= cleanup.amount
                        @pouch = ocFound.user.pouch
                        @pouch.save
                        economyTransaction("Tax", cleanup.amount, ocFound.user.id)
                     end
                     @oc.destroy
                     flash[:success] = "#{ocFound.title} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to ocs_list_path
                     else
                        redirect_to user_ocs_path(ocFound.user)
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
            if(type == "index")
               removeTransactions
               allMode = Maintenancemode.find_by_id(1)
               ocMode = Maintenancemode.find_by_id(8)
               if(allMode.maintenance_on || ocMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/ocs/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               ocMode = Maintenancemode.find_by_id(8)
               if(allMode.maintenance_on || ocMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/ocs/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getOcParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newOc = logged_in.ocs.new
                        if(type == "create")
                           newOc = logged_in.ocs.new(getOcParams("Oc"))
                           newOc.created_on = currentTime
                           newOc.updated_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups

                        #Allows us to select the user who can view the oc
                        gviewers = Gviewer.order("created_on desc")
                        @gviewers = gviewers

                        @oc = newOc
                        @user = userFound

                        if(type == "create")
                           if(@oc.save)
                              octag = Octag.new(params[:octag])
                              octag.oc_id = @oc.id
                              octag.tag1_id = 1
                              @octag = octag
                              @octag.save
                              url = "http://www.duelingpets.net/ocs/review" #"http://localhost:3000/blogs/review"
                              #if(type == "Production")
                              #   url = "http://www.duelingpets.net/blogs/review"
                              #end
                              ContentMailer.content_review(@oc, "OC", url).deliver_now
                              flash[:success] = "#{@oc.name} was successfully created."
                              redirect_to user_oc_path(@user, @oc)
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
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  ocMode = Maintenancemode.find_by_id(8)
                  if(allMode.maintenance_on || ocMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/ocs/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               ocMode = Maintenancemode.find_by_id(8)
               if(allMode.maintenance_on || ocMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/ocs/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allOcs = Oc.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        ocsToReview = allOcs.select{|oc| !oc.reviewed}
                        @ocs = Kaminari.paginate_array(ocsToReview).page(getOcParams("Page")).per(4)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @ocs = allOcs.page(getOcParams("Page")).per(4)
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
                  ocFound = Oc.find_by_id(getOcParams("OcId"))
                  if(ocFound)
                     pouchFound = Pouch.find_by_user_id(ocFound.user.pouch.id)
                     if((logged_in.pouch.privilege == "Admin") || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           ocFound.reviewed = true
                           ocFound.reviewed_on = currentTime
                           if(!ocFound.pointsreceived)
                              price = Fieldcost.find_by_name("OCpoints")
                              pouch.amount -= price.amount
                              @pouch = pouch
                              @pouch.save
                              economyTransaction("Sink", price.amount, ocFound.user.id)
                              ContentMailer.content_approved(ocFound, "OC", pointsForOC).deliver_now
                              ocFound.pointsreceived = true
                           end
                           @oc = ocFound
                           @oc.save
                           #allWatches = Watch.all
                           #watchers = allWatches.select{|watch| (((watch.watchtype.name == "Arts" || watch.watchtype.name == "Blogarts") || (watch.watchtype.name == "Artsounds" || watch.watchtype.name == "Artmovies")) || (watch.watchtype.name == "Maincontent" || watch.watchtype.name == "All")) && watch.from_user.id != @art.user_id}
                           #if(watchers.count > 0)
                           #   watchers.each do |watch|
                           #      UserMailer.new_art(@art, watch).deliver
                           #   end
                           #end
                           flash[:success] = "#{@oc.user.vname}'s oc #{@oc.name} was approved."
                           redirect_to ocs_review_path
                        else
                           @oc = ocFound
                           ContentMailer.content_denied(@oc, "OC").deliver_now
                           flash[:success] = "#{@oc.user.vname}'s oc #{@oc.name} was denied."
                           redirect_to ocs_review_path
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
