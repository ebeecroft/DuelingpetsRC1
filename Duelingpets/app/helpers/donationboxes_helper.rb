module DonationboxesHelper

   private
      def getDonationboxParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "DonationboxId")
            value = params[:donationbox_id]
         elsif(type == "Donationbox")
            value = params.require(:donationbox).permit(:description, :goal, :box_open)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, contentType, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.attribute = "Donation"
         else
            newTransaction.attribute = "Treasury"
         end
         newTransaction.content_type = contentType
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

      def editCommons(type)
         donationboxFound = Donationbox.find_by_id(getDonationboxParams("Id"))
         if(donationboxFound)
            logged_in = current_user
            if(logged_in && (((logged_in.id == donationboxFound.user_id) && !donationboxFound.box_open) || logged_in.pouch.privilege == "Admin"))
               donationboxFound.initialized_on = currentTime
               @donationbox = donationboxFound
               @user = User.find_by_vname(donationboxFound.user.vname)
               if(type == "update")
                  if(donationboxFound.goal <= donationboxFound.capacity)
                     if(@donationbox.update_attributes(getDonationboxParams("Donationbox")))
                        flash[:success] = "#{@donationbox.user.vname}'s donationbox was successfully updated."
                        redirect_to user_path(@donationbox.user)
                     else
                        render "edit"
                     end
                  else
                     flash[:error] = "Donation goal can't exceed capacity of #{@donationbox.capacity} points!"
                     redirect_to user_path(@donationbox.user)
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
                  allDonationboxes = Donationbox.order("initialized_on desc")
                  @donationboxes = Kaminari.paginate_array(allDonationboxes).page(getDonationboxParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "retrieve" || type == "refund")
               logged_in = current_user
               donationboxFound = Donationbox.find_by_id(getDonationboxParams("Id"))
               if((logged_in && donationboxFound) && ((logged_in.id == donationboxFound.user_id) || logged_in.pouch.privilege == "Admin"))
                  errorFlag = -1
                  if(type == "retrieve" && donationboxFound.hitgoal)
                     errorFlag = 0
                     #Calculate the tax
                     points = donationboxFound.progress
                     donationtax = Ratecost.find_by_name("Donationrate")
                     taxinc = donationtax.amount
                     results = `public/Resources/Code/dbox/calc #{points} #{taxinc}`

                     string_array = results.split(",")
                     pointsTax, taxRate = string_array.map{|str| str.to_f}

                     #Send the points to the user's pouch
                     pouch = Pouch.find_by_user_id(donationboxFound.user.id)
                     netPoints = donationboxFound.progress - pointsTax
                     economyTransaction("Source", netPoints, "Donationbox", pouch.user.id, "Points")
                     economyTransaction("Tax", pointsTax, "Donationbox", "None", "Points")
                     CommunityMailer.donations(donationboxFound, "Retrieve", netPoints, taxRate, pointsTax).deliver_now
                     pouch.amount += netPoints
                     @pouch = pouch
                     @pouch.save
                     hoard = Dragonhoard.find_by_id(1)
                     hoard.profit += pointsTax
                     @hoard = hoard
                     @hoard.save
                  elsif(type == "refund" && (logged_in.pouch.privilege == "Admin" || !donationboxFound.hitgoal))
                     errorFlag = 0
                     allDonors = Donor.all
                     boxDonors = allDonors.select{|donor| donor.donationbox_id == boxFound.id}
                     activeDonors = boxDonors.select{|donor| donor.created_on > boxFound.initialized_on}
                     #Gives back the original users donations
                     activeDonors.each do |donor|
                        donor.user.pouch.amount += donor.amount
                        donationboxFound.progress -= donor.amount
                        CommunityMailer.donations(donor, "Refund", donor.amount, 0, 0).deliver_now
                        economyTransaction("Source", donor.amount, "Donor", donor.user.id, "Points")
                        @tempbox = donationboxFound
                        @tempbox.save
                        @pouch = donor.user.pouch
                        @pouch.save
                        @donor = donor
                        @donor.destroy
                     end
                  end

                  if(errorFlag != -1)
                     donationboxFound.goal = 0
                     donationboxFound.progress = 0
                     donationboxFound.hitgoal = false
                     donationboxFound.box_open = false
                  end
                  @user = donationboxFound.user
                  @donationbox = donationboxFound
                  @donationbox.save
                  redirect_to user_path(@donationbox.user)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
