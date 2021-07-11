module PartnersHelper

   private
      def getPartnerParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "PartnerId")
            value = params[:partner_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Partner")
            value = params.require(:partner).permit(:name, :description, :creature_id)
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
            newTransaction.econattr = "Purchase"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Partner"
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

      def indexCommons
         userFound = User.find_by_vname(getPartnerParams("User"))
         if(userFound)
            userPets = userFound.partners.order("updated_on desc, adopted_on desc")
            @user = userFound
            @partners = Kaminari.paginate_array(userPets).page(getPartnerParams("Page")).per(10)
         else
            render "webcontrols/missingpage"
         end
      end

      def editCommons(type)
         partnerFound = Partner.find_by_id(getPartnerParams("Id"))
         if(partnerFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == partnerFound.user_id) || logged_in.pouch.privilege == "Admin"))
               partnerFound.updated_on = currentTime
               @partner = partnerFound
               @user = User.find_by_vname(partnerFound.user.vname)
               if(type == "update")
                  if(@partner.update_attributes(getPartnerParams("Partner")))
                     flash[:success] = "Partner #{@partner.name} was successfully updated."
                     redirect_to user_partner_path(@partner.user, @partner)
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
         partnerFound = Partner.find_by_id(getPartnerParams("Id"))
         if(partnerFound)
            removeTransactions
            #visitTimer(type, blogFound)
            #cleanupOldVisits
            @partner = partnerFound
            if(type == "destroy")
               logged_in = current_user
               if(logged_in && ((logged_in.id == partnerFound.user_id) || logged_in.pouch.privilege == "Admin"))
                  #Eventually consider adding a sink to this
                  user = User.find_by_vname(partnerFound.user.vname)
                  if(user.partners.count == 1 || !partnerFound.activepet)
                     cleanup = (partnerFound.adoptcost * 0.30).round
                     if(partnerFound.user.pouch.amount - cleanup >= 0)
                        #Removes the content and decrements the owner's pouch
                        partnerFound.user.pouch.amount -= cleanup
                        @pouch = partnerFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup, partnerFound.user.id, "Points")
                        flash[:success] = "#{@partner.name} was successfully removed."
                        @partner.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to partners_path
                        else
                           redirect_to partners_mypartners_path(partnerFound.user)
                        end
                     else
                        flash[:error] = "#{@partner.user.vname}'s has insufficient points to remove the partner!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to partners_path
                        else
                           redirect_to partners_mypartners_path(partnerFound.user)
                        end
                     end
                  else
                     flash[:error] = "Can't delete the mainpet!"
                     redirect_to user_path(user)
                  end
               else
                  redirect_to root_path
               end
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def activePet
         userFound = User.find_by_vname(current_user.vname)
         pet = ""
         if(userFound)
            userPets = userFound.partners.order("updated_on desc, adopted_on desc")
            activepet = Partner.find_by_id(userPets.select{|partner| partner.activepet})
            pet = activepet
         end
         return pet
      end

      def storePartner(logged_in)
         #Creating the partner entry
         newPartner = logged_in.partners.new(getPartnerParams("Partner"))
         creatureFound = Creature.find_by_id(newPartner.creature_id)
         newPartner.adopted_on = currentTime
         newPartner.updated_on = currentTime
         newPartner.plevel = (creatureFound.level - 1)
         newPartner.chp = creatureFound.hp
         newPartner.hp = creatureFound.hp
         newPartner.atk = creatureFound.atk
         newPartner.def = creatureFound.def
         newPartner.agility = creatureFound.agility
         newPartner.strength = creatureFound.strength
         newPartner.mlevel = (creatureFound.level - 1)
         newPartner.cmp = creatureFound.mp
         newPartner.mp = creatureFound.mp
         newPartner.matk = creatureFound.matk
         newPartner.mdef = creatureFound.mdef
         newPartner.magi = creatureFound.magi
         newPartner.mstr = creatureFound.mstr
         newPartner.chunger = creatureFound.hunger
         newPartner.hunger = creatureFound.hunger
         newPartner.cthirst = creatureFound.thirst
         newPartner.thirst = creatureFound.thirst
         newPartner.cfun = creatureFound.fun
         newPartner.fun = creatureFound.fun
         newPartner.lives = creatureFound.lives
         if(logged_in.partners.count == 0)
            newPartner.activepet = true
         end

         #Adoptcost should be based off the shopcost value
         newPartner.adoptcost = creatureFound.cost
         newPartner.cost = creatureFound.cost
         return newPartner
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               allMode = Maintenancemode.find_by_id(1)
               creatureMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || creatureMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/creatures/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               creatureMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || creatureMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/creatures/maintenance"
                  end
               else
                  logged_in = current_user
                  if(logged_in)
                     if(type == "new")
                        creatureFound = Creature.find_by_id(params[:partner][:creature_id])
                        if(creatureFound)
                           newPartner = logged_in.partners.new
                           newPartner.creature_id = creatureFound.id
                           @user = logged_in
                           @partner = newPartner
                           @creature = creatureFound
                        else
                           redirect_to root_path
                        end
                     else
                        newPartner = storePartner(logged_in)
                        @partner = newPartner
                        @user = logged_in
                        @creature = creatureFound

                        if(type == "create")
                           validPurchase = ((((logged_in.pouch.amount - @partner.adoptcost >= 0) && (logged_in.pouch.emeraldamount - @partner.creature.emeraldcost >= 0)) && logged_in.partners.count != 0) || (@partner.creature.starter && logged_in.partners.count == 0))
                           if(validPurchase)
                              if(@partner.save)
                                 #Builds the partners equipbag
                                 newEquip = Equip.new(params[:equip])
                                 newEquip.partner_id = newPartner.id
                                 @equip = newEquip
                                 @equip.save

                                 #Builds the partners fight
                                 newFight = Fight.new(params[:fight]) #Does this code still work?
                                 newFight.partner_id = newPartner.id
                                 @fight = newFight
                                 @fight.save

                                 if(logged_in.partners.count > 0)
                                    #This may originally come from the warehouse
                                    logged_in.pouch.amount -= @partner.adoptcost
                                    logged_in.pouch.emeraldamount -= @partner.creature.emeraldcost
                                    @pouch = logged_in.pouch
                                    @pouch.save
                                    economyTransaction("Sink", @partner.adoptcost, @partner.user_id, "Points")
                                    economyTransaction("Sink", @partner.creature.emeraldcost, @partner.user_id, "Emeralds")

                                    #Give the creator the points for the sell of the pet
                                    creator = @partner.creature.user.pouch
                                    creator.amount += @partner.adoptcost
                                    creator.emeraldamount += @partner.creature.emeraldcost
                                    economyTransaction("Source", @partner.adoptcost, @partner.creature.user_id, "Points")
                                    economyTransaction("Source", @partner.creature.emeraldcost, @partner.creature.user_id, "Emeralds")
                                    @creator = creator
                                    @creator.save
                                 end
                                 flash[:success] = "#{@partner.name} was successfully created."
                                 redirect_to user_partner_path(@user, @partner)
                              else
                                 render "new"
                              end
                           else
                              flash[:error] = "Insufficient funds to adopt a creature!"
                              redirect_to root_path
                           end
                        end
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
                  creatureMode = Maintenancemode.find_by_id(10)
                  if(allMode.maintenance_on || creatureMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/creatures/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               creatureMode = Maintenancemode.find_by_id(10)
               if(allMode.maintenance_on || creatureMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/creatures/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list")
               if(current_user && current_user.pouch.privilege == "Admin")
                  allPets = Partner.order("updated_on desc, adopted_on desc")
                  @partners = Kaminari.paginate_array(allPets).page(getPartnerParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "setactive")
               partnerFound = Partner.find_by_id(getPartnerParams("PartnerId"))
               logged_in = current_user
               if(logged_in && partnerFound && logged_in.id == partnerFound.user_id)
                  if(!partnerFound.activepet)
                     #Unsets the previous mainpet
                     pets = logged_in.partners.order("updated_on desc, adopted_on desc")
                     pets.each do |partner|
                        if(partner.activepet)
                           partner.activepet = false
                           @pet = partner
                           @pet.save
                        end
                     end
                     partnerFound.activepet = true
                     @partner = partnerFound
                     @partner.save
                     flash[:success] = "{partnerFound.name} is now the mainpet!"
                     redirect_to user_partner_path(@partner.user, @partner)
                  else
                     flash[:error] = "That pet is already the mainpet!"
                     redirect_to user_path(logged_in)
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
