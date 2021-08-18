module ReferralsHelper

   private
      def getReferralParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Referral")
            value = params.require(:referral).permit(:referred_by_id)
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
            newTransaction.econattr = "Follower"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Referral"
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
                  allReferrals = Referral.order("created_on desc")
                  @referrals = Kaminari.paginate_array(allReferrals).page(getReferralParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/users/maintenance"
                  end
               else
                  logged_in = current_user
                  mainUser = User.find_by_vname(getReferralParams("User"))
                  if((logged_in && mainUser) && (logged_in.id == mainUser.id))
                     allReferrals = Referral.all
                     inList = allReferrals.select{|referral| referral.user_id == mainUser.id}
                     if(inList.count == 0)
                        newReferral = logged_in.referrals.new
                        errorFlag = 0
                        if(type == "create")
                           userFound = User.find_by_vname(params[:referral][:vname].downcase)
                           if(userFound && logged_in.id != userFound.id)
                              newReferral = Referral.new(getReferralParams("Referral"))
                              newReferral.created_on = currentTime
                              newReferral.user_id = logged_in.id
                              validReferral = ((userFound.pouch.privilege != "Bot" && userFound.pouch.privilege != "Admin") && (userFound.pouch.privilege != "Trial" && userFound.pouch.privilege != "Glitchy"))
                              if(validReferral)
                                 newReferral.referred_by_id = userFound.id
                              else
                                 errorFlag = 2
                              end
                           else
                              errorFlag = 1
                           end
                        end
                        @user = User.find_by_vname(logged_in.vname)
                        @referral = newReferral
                        if(type == "create")
                           if(errorFlag != 1 && errorFlag != 2)
                              if(logged_in.gameinfo.startgame)
                                 #Stores the referral
                                 @referral.save
                                 referralPoints = Fieldcost.find_by_name("Referral")
                                 pouch = Pouch.find_by_id(@referral.referred_by_id)
                                 pouch.amount += referralPoints.amount
                                 @pouch = pouch
                                 @pouch.save
                                 economyTransaction("Source", referralPoints.amount, pouch.user.id, "Points")

                                 #Emails the user about the new referral
                                 ContentMailer.content_created(@referral, "Referral", referralPoints.amount).deliver_now
                                 flash[:success] = "#{@referral.referred_by.vname} successfully referred someone!"
                                 redirect_to user_path(@user)
                              else
                                 flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                                 redirect_to edit_gameinfo_path(logged_in.gameinfo)
                              end
                           else
                              flash[:error] = "Referral name was invalid!"
                              render "new"
                           end
                        end
                     else
                        flash[:error] = "Your referral is already set!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  referralFound = Referral.find_by_id(getReferralParams("Id"))
                  if(referralFound)
                     @user = referralFound.user
                     @referral = referralFound
                     if(type == "update")
                        userFound = User.find_by_vname(params[:referral][:vname].downcase)
                        if(userFound && userFound.id != referralFound.user_id)
                           referralFound.referred_by_id = userFound.id
                           @referral = referralFound
                           if(@referral.update_attributes(getReferralParams("Referral")))
                              flash[:success] = "#{@referral.user.vname} referral was successfully updated!"
                           end
                           redirect_to referrals_path
                        else
                           flash.now[:error] = "Referral name was invalid!"
                           render "edit"
                        end
                     end
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "discoveredit")
               allMode = Maintenancemode.find_by_id(1)
               userMode = Maintenancemode.find_by_id(6)
               if(allMode.maintenance_on || userMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/users/maintenance"
                  end
               else
                  logged_in = current_user
                  if(logged_in && logged_in.referral.nil?)
                     if(logged_in.user.gameinfo.startgame)
                        #Creates the referral for discoveredit users
                        newReferral = Referral.new
                        newReferral.user_id = logged_in.id
                        newReferral.created_on = currentTime
                        newReferral.referred_by_id = 1
                        @user = User.find_by_vname(logged_in.vname)
                        @referral = newReferral

                        #Stores the referral
                        @referral.save
                        referralPoints = Fieldcost.find_by_name("Referral")
                        pouch = Pouch.find_by_id(@referral.referred_by_id)
                        pouch.amount += referralPoints.amount
                        @pouch = pouch
                        @pouch.save
                        economyTransaction("Source", referralPoints.amount, pouch.user.id, "Points")

                        #Emails the user about the new referral
                        ContentMailer.content_created(@referral, "Referral", referralPoints.amount).deliver_now
                        flash[:success] = "#{@referral.referred_by.vname} successfully referred someone!"
                        redirect_to user_path(@user)
                     else
                        flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                        redirect_to edit_gameinfo_path(logged_in.gameinfo)
                     end
                  else
                     redirect_to root_path
                  end
               end
            end
         end
      end
end
