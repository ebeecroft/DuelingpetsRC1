module DonorsHelper

   private
      def getDonorParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "DonorId")
            value = params[:donor_id]
         elsif(type == "Donor")
            value = params.require(:donor).permit(:description, :amount)
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
            newTransaction.econattr = "Donation"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Donor"
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
                  allDonors = Donor.order("updated_on desc, created_on desc")
                  @donors = Kaminari.paginate_array(allDonors).page(getDonorParams("Page")).per(10)
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
                  donationboxFound = Donationbox.find_by_id(params[:donationbox_id])
                  if((logged_in && donationboxFound) && (logged_in.id != donationboxFound.user.id))
                     if(donationboxFound.box_open)
                        if(type == "new")
                           newDonor = donationboxFound.donors.new
                           @donationbox = donationboxFound
                           @donor = newDonor
                        else
                           newDonor = donationboxFound.donors.new(getDonorParams("Donor"))
                           newDonor.created_on = currentTime
                           newDonor.updated_on = currentTime
                           newDonor.user_id = logged_in.id
                           @donor = newDonor
                           @donationbox = donationboxFound
                           if(@donor.valid? && @donationbox.valid?)
                              capacityCheck = (@donor.amount <= @donor.capacity)
                              donationCheck = (logged_in.pouch.amount > 0 && logged_in.pouch.amount - @donor.amount >= 0)
                              boxCheck = (donationboxFound.progress + @donor.amount <= donationboxFound.capacity)
                              if((capacityCheck && donationCheck) && boxCheck)
                                 if(logged_in.gameinfo.startgame && donationboxFound.user.gameinfo.startgame)
                                    if(@donor.save)
                                       points = donationboxFound.progress + @donor.amount
                                       donationboxFound.progress = points
                                       reachedGoal = (donationboxFound.progress >= donationboxFound.goal && !donationboxFound.hitgoal)
                                       if(reachedGoal)
                                          donationboxFound.hitgoal = true
                                          profit = donationboxFound.progress - donationboxFound.goal
                                          CommunityMailer.donations(@donor, "Goal", profit, 0, points).deliver_now
                                       end
                                       @donationbox.save
                                       logged_in.pouch.amount -= @donor.amount
                                       @pouch = logged_in.pouch
                                       @pouch.save
                                       economyTransaction("Sink", @donor.amount, logged_in.id, "Points")
                                       flash[:success] = "#{@donor.user.vname}'s donation was successfully added!"
                                       CommunityMailer.donations(@donor, "Donated", @donor.amount, 0, 0).deliver_now
                                       redirect_to user_path(@donationbox.user)
                                    else
                                       @donationbox = donationboxFound
                                       render "new"
                                    end
                                 else
                                    if(!logged_in.gameinfo.startgame)
                                       flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                                       redirect_to edit_gameinfo_path(logged_in.gameinfo)
                                    else
                                       flash[:error] = "The user has not activated the game yet!"
                                       redirect_to user_path(logged_in)
                                    end
                                 end
                              else
                                 #Returns the specific error message to the user
                                 if(!donationCheck)
                                    message = "#{@donor.user.vname}'s doesn't have that many points to donate!"
                                 elsif(!capacityCheck)
                                    message = "You exceeded the donation limit of #{@donor.capacity} points!"
                                 else
                                    message = "The donationbox can't store that many points!"
                                 end
                                 flash[:error] = message
                                 redirect_to user_path(logged_in)
                              end
                           else
                              flash[:error] = "Donationbox or Donor information was invalid!"
                              redirect_to root_path
                           end
                        end
                     else
                        flash[:error] = "User's donationbox is not open at this time!"
                        redirect_to user_path(donationboxFound.user)
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "mydonors")
               logged_in = current_user
               donationboxFound = Donationbox.find_by_id(params[:donationbox_id])
               if(logged_in && donationboxFound)
                  removeTransactions
                  donors = donationboxFound.donors.order("updated_on desc, created_on desc")
                  @donationbox = donationboxFound
                  @donors = Kaminari.paginate_array(donors).page(getDonorParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
