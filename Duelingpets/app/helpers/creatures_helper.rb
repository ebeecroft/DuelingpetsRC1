module CreaturesHelper

   private
      def getCreatureParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "CreatureId")
            value = params[:creature_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Creature")
            value = params.require(:creature).permit(:name, :description, :hp, :atk, :def, :agility, :strength, :mp, :matk, :mdef, :magi, :mstr, :hunger, :thirst, :fun, :lives, :rarity, :starter, :emeraldcost, :unlimitedlives, :image, :remote_image_url, :image_cache, :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache, :voiceogg, :remote_voiceogg_url, :voiceogg_cache, :voicemp3, :remote_voicemp3_url, :voicemp3_cache, :creaturetype_id, :element_id, :activepet, :remote_activepet_url, :activepet_cache)
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
            newTransaction.econattr = "Content"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Creature"
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

      def getCreatureStats(creature, type)
         value = 0
         if(type == "Level")
            value = creature.level
         elsif(type == "HP")
            value = (creature.creaturetype.basehp + (creature.hp * 4))
         elsif(type == "Atk")
            value = (creature.creaturetype.baseatk + creature.atk)
         elsif(type == "Def")
            value = (creature.creaturetype.basedef + creature.def)
         elsif(type == "Agi")
            value = (creature.creaturetype.baseagi + creature.agility)
         elsif(type == "Str")
            value = (creature.creaturetype.basestr + creature.strength)
         elsif(type == "MP")
            value = creature.mp * 4
         elsif(type == "Matk")
            value = creature.matk
         elsif(type == "Mdef")
            value = creature.mdef
         elsif(type == "Magi")
            value = creature.magi
         elsif(type == "Mstr")
            value = creature.mstr
         elsif(type == "Hunger")
            value = (creature.creaturetype.basehunger + creature.hunger)
         elsif(type == "Thirst")
            value = (creature.creaturetype.basethirst + creature.thirst)
         elsif(type == "Fun")
            value = (creature.creaturetype.basefun + creature.fun)
         elsif(type == "Lives")
            value = creature.lives
         elsif(type == "Rarity")
            value = creature.rarity
         end
         return value
      end

      def validatePetStats(level)
         #Determines the error message
         if(level == -1)
            message = "MP can't be 0 if magic fields are not 0!"
         elsif(level == -2)
            message = "MP can't be set to 4 or more if magic fields are set to 0!"
         elsif(level == -3)
            message = "MP can't be set to a value between 0 and 4!"
         elsif(level == -4)
            message = "Creature's total skill points is not divisible by 14!"
         elsif(level == -5)
            message = "Rarity can't be 0!"
         elsif(level == -6)
            message = "Creature skill values can't be empty!"
         end
         flash[:error] = message
      end

      def getPetCalc(creature)
         if(!creature.hp.nil? && !creature.atk.nil? && !creature.def.nil? && !creature.agility.nil? && !creature.strength.nil? && !creature.mp.nil? && !creature.matk.nil? && !creature.mdef.nil? && !creature.magi.nil? && !creature.mstr.nil? && !creature.hunger.nil? && !creature.thirst.nil? && !creature.fun.nil? && !creature.lives.nil? && !creature.rarity.nil? && !creature.creaturetype.basecost.nil?)
            #Application that calculates level and cost
            #Rework this area
            results = `public/Resources/Code/petcalc/calc #{creature.hp} #{creature.atk} #{creature.def} #{creature.agility} #{creature.strength} #{creature.mp} #{creature.matk} #{creature.mdef} #{creature.magi} #{creature.mstr} #{creature.hunger} #{creature.thirst} #{creature.fun} #{creature.lives} #{creature.rarity} #{creature.creaturetype.basecost}`
            petAttributes = results.split(",")
            petCost, petLevel = petAttributes.map{|str| str.to_i}
            @creature = creature
            @creature.cost = petCost
            @creature.level = petLevel
         else
            @creature.level = -6
         end
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userCreatures = userFound.creatures.order("reviewed_on desc, created_on desc")
               creaturesReviewed = userCreatures.select{|creature| (current_user && creature.user_id == current_user.id) || creature.reviewed}
               @user = userFound
            else
               render "webcontrols/missingpage"
            end
         else
            allCreatures = Creature.order("reviewed_on desc, created_on desc")
            creaturesReviewed = allCreatures.select{|creature| (current_user && creature.user_id == current_user.id) || creature.reviewed}
         end
         @creatures = Kaminari.paginate_array(creaturesReviewed).page(getCreatureParams("Page")).per(10)
      end

      def optional
         value = getCreatureParams("User")
         return value
      end

      def editCommons(type)
         creatureFound = Creature.find_by_name(getCreatureParams("Id"))
         if(creatureFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == creatureFound.user_id) || logged_in.pouch.privilege == "Admin"))
               creatureFound.updated_on = currentTime
               #Determines the creaturetype
               allCreaturetypes = Creaturetype.order("created_on desc")
               @creaturetypes = allCreaturetypes
               allElements = Element.order("created_on desc")
               @elements = allElements
               creatureFound.reviewed = false
               @creature = creatureFound
               @user = User.find_by_vname(creatureFound.user.vname)
               if(type == "update")
                  #Update creature stats should only happen if not reviewed
                  if(@creature.update_attributes(getCreatureParams("Creature")))
                     flash[:success] = "Creature #{@creature.name} was successfully updated."
                     redirect_to user_creature_path(@creature.user, @creature)
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
         creatureFound = Creature.find_by_name(getCreatureParams("Id"))
         if(creatureFound)
            removeTransactions
            if(creatureFound.reviewed || current_user && ((creatureFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @creature = creatureFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == creatureFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Removes the content and decrements the owner's pouch
                     price = creatureFound.cost * 0.60
                     if(creatureFound.user.pouch.amount - price >= 0)
                        if(creatureFound.user.gameinfo.startgame)
                           creatureFound.user.pouch.amount -= price
                           @pouch = creatureFound.user.pouch
                           @pouch.save
                           economyTransaction("Sink", price, creatureFound.user.id, "Points")
                           @creature.destroy
                           flash[:success] = "#{@creature.name} was successfully removed."
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to creatures_list_path
                           else
                              redirect_to user_creatures_path(creatureFound.user)
                           end
                        else
                           if(logged_in.pouch.privilege == "Admin")
                              flash[:error] = "The creator has not activated the game yet!"
                              redirect_to creatures_list_path
                           else
                              flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                              redirect_to edit_gameinfo_path(logged_in.gameinfo)
                           end
                        end
                     else
                        flash[:error] = "#{@creature.user.vname}'s has insufficient points to remove the creature!"
                        redirect_to root_path
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
                  userFound = User.find_by_vname(getCreatureParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newCreature = logged_in.creatures.new
                        if(type == "create")
                           newCreature = logged_in.creatures.new(getCreatureParams("Creature"))
                           newCreature.created_on = currentTime
                           newCreature.updated_on = currentTime
                        end
                        #Determines the type of bookgroup the user belongs to
                        allCreaturetypes = Creaturetype.order("created_on desc")
                        @creaturetypes = allCreaturetypes
                        allElements = Element.order("created_on desc")
                        @elements = allElements

                        @creature = newCreature
                        @user = userFound

                        if(type == "create")
                           getPetCalc(@creature)
                           if(@creature.level > 0)
                              if(@creature.save)
                                 url = "http://www.duelingpets.net/creatures/review"
                                 ContentMailer.content_review(@creature, "Creature", url).deliver_now
                                 flash[:success] = "#{@creature.name} was successfully created."
                                 redirect_to user_creature_path(@user, @creature)
                              else
                                 render "new"
                              end
                           else
                              validatePetStats(@creature.level)
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
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allCreatures = Creature.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        creaturesToReview = allCreatures.select{|creature| !creature.reviewed}
                        @creatures = Kaminari.paginate_array(creaturesToReview).page(getCreatureParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @creatures = allCreatures.page(getCreatureParams("Page")).per(10)
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
                  creatureFound = Creature.find_by_id(getCreatureParams("CreatureId"))
                  if(creatureFound)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           creatureFound.reviewed = true
                           creatureFound.reviewed_on = currentTime
                           basecost = creatureFound.creaturetype.basecost
                           price = ((basecost + creatureFound.cost) * 0.70).round
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price * rate.amount)
                           pouch = Pouch.find_by_user_id(creatureFound.user_id)
                           #Add dreyterrium cost later
                           if(pouch.amount - price >= 0)
                              if(creatureFound.user.gameinfo.startgame)
                                 @creature = creatureFound
                                 @creature.save
                                 pouch.amount -= price
                                 @pouch = pouch
                                 @pouch.save
                                 hoard = Dragonhoard.find_by_id(1)
                                 hoard.profit += tax
                                 @hoard = hoard
                                 @hoard.save
                                 economyTransaction("Sink", price - tax, creatureFound.user.id, "Points")
                                 economyTransaction("Tax", tax, creatureFound.user.id, "Points")
                                 ContentMailer.content_approved(@creature, "Creature", price).deliver_now
                                 flash[:success] = "#{@creature.user.vname}'s creature #{@creature.name} was approved."
                                 redirect_to creatures_review_path
                              else
                                 flash[:error] = "The creator has not activated the game yet!"
                                 redirect_to creatures_review_path
                              end
                           else
                              flash[:error] = "Insufficient funds to create a creature!"
                              redirect_to creatures_review_path
                           end
                        else
                           @creature = creatureFound
                           ContentMailer.content_denied(@creature, "Creature").deliver_now
                           flash[:success] = "#{@creature.user.vname}'s creature #{@creature.name} was denied."
                           redirect_to creatures_review_path
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
