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
            #Add Knowledge here later
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

      def validateMonsterStats(level)
         minhp = 30
         minatk = 16
         mindef = 16
         minagi = 16
         minexp = 10

         #Determines the error message
         if(level == -1)
            message = "HP is below min value of #{minhp}!"
         elsif(level == -2)
            message = "ATK is below min value of #{minatk}!"
         elsif(level == -3)
            message = "DEF is below min value of #{mindef}!"
         elsif(level == -4)
            message = "AGI is below min value of #{minagi}!"
         elsif(level == -5)
            message = "MP can't be 0 if magic fields are not 0!"
         elsif(level == -6)
            message = "MP can't be set to 5 or more if magic fields are set to 0!"
         elsif(level == -7)
            message = "MP can't be set to a value between 0 and 5!"
         elsif(level == -8)
            message = "Exp is below min value of #{minexp}!"
         elsif(level == -9)
            message = "Creature's total skill points is not divisible by 18!"
         elsif(level == -10)
            message = "Rarity can't be 0!"
         elsif(level == -11)
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
            @monster.level = -11
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
                     #Eventually consider adding a sink to this
                     @monster.destroy
                     flash[:success] = "#{@monster.name} was successfully removed."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to monsters_list_path
                     else
                        redirect_to user_monsters_path(monsterFound.user)
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
                           monstercost = Fieldcost.find_by_name("Monster")
                           mcost = (monsterFound.cost * 0.10).round
                           price = 20
                           #price = (basecost + monstercost.amount + mcost)
                           pouch = Pouch.find_by_user_id(monsterFound.user_id)
                           #Add dreyterrium cost later
                           if(pouch.amount - price >= 0)
                              @monster = monsterFound
                              @monster.save
                              pouch.amount -= price
                              @pouch = pouch
                              @pouch.save

                              #Adds the creature points to the economy
                              newTransaction = Economy.new(params[:economy])
                              newTransaction.econtype = "Content"
                              newTransaction.content_type = "Monster"
                              newTransaction.name = "Sink"
                              newTransaction.amount = price
                              newTransaction.user_id = monsterFound.user_id
                              newTransaction.created_on = currentTime
                              @economytransaction = newTransaction
                              @economytransaction.save
                              ContentMailer.content_approved(@monster, "Monster", price).deliver_now
                              value = "#{@monster.user.vname}'s monster #{@monster.name} was approved."
                           else
                              flash[:error] = "Insufficient funds to create a monster!"
                              redirect_to user_path(logged_in.id)
                           end
                        else
                           @monster = monsterFound
                           ContentMailer.content_denied(@monster, "Monster").deliver_now
                           value = "#{@monster.user.vname}'s monster #{@monster.name} was denied."
                        end
                        flash[:success] = value
                        redirect_to monsters_review_path
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
