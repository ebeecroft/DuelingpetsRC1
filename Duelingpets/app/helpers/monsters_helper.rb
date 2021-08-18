module MonstersHelper

   private
      def getMonsterParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "MonsterId")
            value = params[:monster_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Monster")
            value = params.require(:monster).permit(:name, :description, :hp, :atk, :def, :agility, 
            :mp, :matk, :mdef, :magi, :exp, :nightmare, :shinycraze, :party, :mischief, :rarity, :image,
            :remote_image_url, :image_cache, :ogg, :remote_ogg_url, :ogg_cache, :mp3,
            :remote_mp3_url, :mp3_cache, :monstertype_id, :element_id)
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
         newTransaction.content_type = "Monster"
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
      
      def getMonsterStats(monster, type)
         value = 0
         if(type == "Level")
            value = monster.level
         elsif(type == "HP")
            value = (monster.monstertype.basehp + (monster.hp * 4))
         elsif(type == "Atk")
            value = (monster.monstertype.baseatk + monster.atk)
         elsif(type == "Def")
            value = (monster.monstertype.basedef + monster.def)
         elsif(type == "Agi")
            value = (monster.monstertype.baseagi + monster.agility)
         elsif(type == "MP")
            value = monster.mp * 4
         elsif(type == "Matk")
            value = monster.matk
         elsif(type == "Mdef")
            value = monster.mdef
         elsif(type == "Magi")
            value = monster.magi
         elsif(type == "Exp")
            value = monster.exp + monster.monstertype.baseexp
         elsif(type == "Loot")
            value = monster.loot
         elsif(type == "Nightmare")
            value = monster.nightmare + monster.monstertype.basenightmare
         elsif(type == "Shinycraze")
            value = monster.shinycraze + monster.monstertype.baseshinycraze
         elsif(type == "Party")
            value = monster.party + monster.monstertype.baseparty
         elsif(type == "Rarity")
            value = monster.rarity
         end
         return value
      end
      
      def validateMonsterStats(level)
         #Determines the error message
         if(level == -1)
            message = "MP can't be 0 if magic fields are not 0!"
         elsif(level == -2)
            message = "MP can't be set to 5 or more if magic fields are set to 0!"
         elsif(level == -3)
            message = "MP can't be set to a value between 0 and 5!"
         elsif(level == -4)
            message = "monster's total skill points is not divisible by 18!" #12 stats
         elsif(level == -5)
            message = "Rarity can't be 0!"
         elsif(level == -6)
            message = "Monster skill values can't be empty!"
         end
         flash[:error] = message
      end

      def getMonsterCalc(monster)
         if(!monster.hp.nil? && !monster.atk.nil? && !monster.def.nil? && !monster.agility.nil? && !monster.mp.nil? && !monster.matk.nil? && !monster.mdef.nil? && !monster.magi.nil? && !monster.exp.nil? && !monster.rarity.nil? && !monster.monstertype.basecost.nil?)
            #Application that calculates level, loot and cost
            results = `public/Resources/Code/monstercalc/calc #{monster.hp} #{monster.atk} #{monster.def} #{monster.agility} #{monster.mp} #{monster.matk} #{monster.mdef} #{monster.magi} #{monster.exp} #{monster.nightmare} #{monster.shinycraze} #{monster.party} #{monster.rarity} #{monster.monstertype.basecost}`
            monsterAttributes = results.split(",")
            monsterCost, monsterLevel, monsterLoot = monsterAttributes.map{|str| str.to_i}
            @monster = monster
            @monster.cost = monsterCost
            @monster.level = monsterLevel
            @monster.loot = monsterLoot
         else
            @monster.level = -6
         end
      end

      def indexCommons
         if(optional)
            userFound = User.find_by_vname(optional)
            if(userFound)
               userMonsters = userFound.monsters.order("reviewed_on desc, created_on desc")
               monstersReviewed = userMonsters.select{|monster| (current_user && monster.user_id == current_user.id) || monster.reviewed}
               @user = userFound
            else
               render "webcontrols/crazybat"
            end
         else
            allMonsters = Monster.order("reviewed_on desc, created_on desc")
            monstersReviewed = allMonsters.select{|monster| (current_user && monster.user_id == current_user.id) || monster.reviewed}
         end
         @monsters = Kaminari.paginate_array(monstersReviewed).page(getMonsterParams("Page")).per(10)
      end

      def optional
         value = getMonsterParams("User")
         return value
      end

      def editCommons(type)
         monsterFound = Monster.find_by_name(getMonsterParams("Id"))
         if(monsterFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == monsterFound.user_id) || logged_in.pouch.privilege == "Admin"))
               monsterFound.updated_on = currentTime
               #Determines the monstertype
               allMonstertypes = Monstertype.order("created_on desc")
               @monstertypes = allMonstertypes
               allElements = Element.order("created_on desc")
               @elements = allElements
               monsterFound.reviewed = false
               @monster = monsterFound
               @user = User.find_by_vname(monsterFound.user.vname)
               if(type == "update")
                  #Update monster stats should only happen if not reviewed
                  if(@monster.update_attributes(getMonsterParams("Monster")))
                     flash[:success] = "Monster #{@monster.name} was successfully updated."
                     redirect_to user_monster_path(@monster.user, @monster)
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
         monsterFound = Monster.find_by_name(getMonsterParams("Id"))
         if(monsterFound)
            removeTransactions
            if(monsterFound.reviewed || current_user && ((monsterFound.user_id == current_user.id) || current_user.pouch.privilege == "Admin"))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @monster = monsterFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == monsterFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     #Removes the content and decrements the owner's pouch
                     price = monsterFound.cost * 0.60
                     if(monsterFound.user.pouch.amount - price >= 0)
                        if(monsterFound.user.gameinfo.startgame)
                           monsterFound.user.pouch.amount -= price
                           @pouch = monsterFound.user.pouch
                           @pouch.save
                           economyTransaction("Sink", price, monsterFound.user.id, "Points")
                           @monster.destroy
                           flash[:success] = "#{@monster.name} was successfully removed."
                           if(logged_in.pouch.privilege == "Admin")
                              redirect_to monsters_list_path
                           else
                              redirect_to user_monsters_path(monsterFound.user)
                           end
                        else
                           if(logged_in.pouch.privilege == "Admin")
                              flash[:error] = "The creator has not activated the game yet!"
                              redirect_to monsters_list_path
                           else
                              flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                              redirect_to edit_gameinfo_path(logged_in.gameinfo)
                           end
                        end
                     else
                        flash[:error] = "#{@monster.user.vname}'s has insufficient points to remove the monster!"
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
               monsterMode = Maintenancemode.find_by_id(15)
               if(allMode.maintenance_on || monsterMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     indexCommons
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/monsters/maintenance"
                     end
                  end
               else
                  indexCommons
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               monsterMode = Maintenancemode.find_by_id(15)
               if(allMode.maintenance_on || monsterMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/monsters/maintenance"
                  end
               else
                  logged_in = current_user
                  userFound = User.find_by_vname(getMonsterParams("User"))
                  if(logged_in && userFound)
                     if(logged_in.id == userFound.id)
                        newMonster = logged_in.monsters.new
                        if(type == "create")
                           newMonster = logged_in.monsters.new(getMonsterParams("Monster"))
                           newMonster.created_on = currentTime
                           newMonster.updated_on = currentTime
                        end
                        allMonstertypes = Monstertype.order("created_on desc")
                        @monstertypes = allMonstertypes
                        allElements = Element.order("created_on desc")
                        @elements = allElements

                        @monster = newMonster
                        @user = userFound

                        if(type == "create")
                           getMonsterCalc(@monster)
                           if(@monster.level > 0)
                              if(@monster.save)
                                 url = "http://www.duelingpets.net/monsters/review"
                                 ContentMailer.content_review(@monster, "Monster", url).deliver_now
                                 flash[:success] = "#{@monster.name} was successfully created."
                                 redirect_to user_monster_path(@user, @monster)
                              else
                                 render "new"
                              end
                           else
                              validateMonsterStats(@monster.level)
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
                  monsterMode = Maintenancemode.find_by_id(15)
                  if(allMode.maintenance_on || monsterMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/monsters/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               monsterMode = Maintenancemode.find_by_id(15)
               if(allMode.maintenance_on || monsterMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/monsters/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "list" || type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allMonsters = Monster.order("reviewed_on desc, created_on desc")
                  if(type == "review")
                     if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        monstersToReview = allMonsters.select{|monster| !monster.reviewed}
                        @monsters = Kaminari.paginate_array(monstersToReview).page(getMonsterParams("Page")).per(10)
                     else
                        redirect_to root_path
                     end
                  else
                     if(logged_in.pouch.privilege == "Admin")
                        @monsters = allMonsters.page(getMonsterParams("Page")).per(10)
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
                  monsterFound = Monster.find_by_id(getMonsterParams("MonsterId"))
                  if(monsterFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((pouchFound.privilege == "Keymaster") || (pouchFound.privilege == "Reviewer")))
                        if(type == "approve")
                           #Might revise this section later
                           monsterFound.reviewed = true
                           monsterFound.reviewed_on = currentTime
                           basecost = monsterFound.monstertype.basecost
                           price = ((basecost + creatureFound.cost) * 0.70).round
                           rate = Ratecost.find_by_name("Purchaserate")
                           tax = (price * rate.amount)
                           pouch = Pouch.find_by_user_id(monsterFound.user_id)
                           #Add dreyterrium cost later
                           if(pouch.amount - price >= 0)
                              if(monsterFound.user.gameinfo.startgame)
                                 @monster = monsterFound
                                 @monster.save
                                 pouch.amount -= price
                                 @pouch = pouch
                                 @pouch.save
                                 hoard = Dragonhoard.find_by_id(1)
                                 hoard.profit += tax
                                 @hoard = hoard
                                 @hoard.save
                                 economyTransaction("Sink", price - tax, monsterFound.user.id, "Points")
                                 economyTransaction("Tax", tax, monsterFound.user.id, "Points")
                                 ContentMailer.content_approved(@monster, "Monster", price).deliver_now
                                 flash[:success] = "#{@monster.user.vname}'s monster #{@monster.name} was approved."
                                 redirect_to monsters_review_path
                              else
                                 flash[:error] = "The creator has not activated the game yet!"
                                 redirect_to monsters_review_path
                              end
                           else
                              flash[:error] = "Insufficient funds to create a monster!"
                              redirect_to user_path(logged_in.id)
                           end
                        else
                           @monster = monsterFound
                           ContentMailer.content_denied(@monster, "Monster").deliver_now
                           flash[:success] = "#{@monster.user.vname}'s monster #{@monster.name} was denied."
                           redirect_to monsters_review_path
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
            elsif(type == "cave")
               allMode = Maintenancemode.find_by_id(1)
               monsterMode = Maintenancemode.find_by_id(15)
               if(allMode.maintenance_on || monsterMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/monsters/maintenance"
                  end
               else
                  logged_in = current_user
                  if(logged_in)
                     allPartners = Partner.all
                     mypartners = allPartners.select{|partner| partner.user_id == logged_in.id && !partner.inbattle}
                     if(mypartners.count > 0)
                        @pets = mypartners
                        allMonsters = Monster.order("reviewed_on desc, created_on desc")
                        monstersReviewed = allMonsters.select{|monster| (monster.reviewed && logged_in.partners.count > 0)}
                        @monsters = Kaminari.paginate_array(monstersReviewed).page(getMonsterParams("Page")).per(9)
                     else
                        flash[:error] = "You don't have any partners left!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            end
         end
      end
end
