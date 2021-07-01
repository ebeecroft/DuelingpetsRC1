module MonsterbattlesHelper

   private
      def getMonsterbattleParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "MonsterbattleId")
            value = params[:monsterbattle_id]
         elsif(type == "User")
            value = params[:user_id]
         elsif(type == "Monsterbattle")
            value = params[:monsterbattle]
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
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

      def getBattleCalc(monsterbattle)
         #Sets up variables to check validity of partner and monster
         partnerValid = (!monsterbattle.partner_plevel.nil? && !monsterbattle.partner_chp.nil? && !monsterbattle.partner_hp.nil? && !monsterbattle.partner_atk.nil? && !monsterbattle.partner_def.nil? && !monsterbattle.partner_agility.nil? && !monsterbattle.partner_strength.nil? && !monsterbattle.partner_mlevel.nil? && !monsterbattle.partner_cmp.nil? && !monsterbattle.partner_mp.nil? && !monsterbattle.partner_matk.nil? && !monsterbattle.partner_mdef.nil? && !monsterbattle.partner_magi.nil? && !monsterbattle.partner_mstr.nil?)
         monsterValid = (!monsterbattle.monster_plevel.nil? && !monsterbattle.monster_chp.nil? && !monsterbattle.monster_hp.nil? && !monsterbattle.monster_atk.nil? && !monsterbattle.monster_def.nil? && !monsterbattle.monster_agility.nil? && !monsterbattle.monster_mlevel.nil? && !monsterbattle.monster_cmp.nil? && !monsterbattle.monster_mp.nil? && !monsterbattle.monster_matk.nil? && !monsterbattle.monster_mdef.nil? && !monsterbattle.monster_magi.nil?)
         if(partnerValid && monsterValid && !monsterbattle.battleover)
            results = `public/Resources/Code/battlecalc/calc #{monsterbattle.partner_plevel} #{monsterbattle.partner_chp} #{monsterbattle.partner_hp} #{monsterbattle.partner_atk} #{monsterbattle.partner_def} #{monsterbattle.partner_agility} #{monsterbattle.partner_strength} #{monsterbattle.partner_mlevel} #{monsterbattle.partner_cmp} #{monsterbattle.partner_mp} #{monsterbattle.partner_matk} #{monsterbattle.partner_mdef} #{monsterbattle.partner_magi} #{monsterbattle.partner_mstr} #{monsterbattle.monster_plevel} #{monsterbattle.monster_chp} #{monsterbattle.monster_hp} #{monsterbattle.monster_atk} #{monsterbattle.monster_def} #{monsterbattle.monster_agility} #{monsterbattle.monster_mlevel} #{monsterbattle.monster_cmp} #{monsterbattle.monster_mp} #{monsterbattle.monster_matk} #{monsterbattle.monster_mdef} #{monsterbattle.monster_magi}`
            #May change once equips are added
            battleAttributes = results.split(",")
            petDamage, monsterDamage, petHPLeft, monsterHPLeft = battleAttributes.map{|str| str.to_i}
            if(monsterbattle.partner_chp - monsterDamage < 0)
               monsterbattle.partner_chp = 0
            elsif(monsterDamage > 0)
               monsterbattle.partner_chp -= monsterDamage
            end
            if(monsterbattle.monster_chp - petDamage < 0)
               monsterbattle.monster_chp = 0
            elsif(petDamage > 0)
               monsterbattle.monster_chp -= petDamage
            end
            monsterbattle.monster_damage = monsterDamage
            monsterbattle.partner_damage = petDamage
            monsterbattle.round += 1
            if(petHPLeft <= 0 || monsterHPLeft <= 0)
               results2 = `public/Resources/Code/battleresults/calc #{petHPLeft} #{monsterHPLeft}`
               battlestatus = results2
               partner = Partner.find_by_id(monsterbattle.fight.partner.id)
               partner.inbattle = false
               partner.chp = monsterbattle.partner_chp
               if(battlestatus != "Loss")
                  results3 = `public/Resources/Code/levelup/calc #{monsterbattle.partner_plevel} #{monsterbattle.partner_pexp} #{getMonsterStats(monsterbattle.monster, "Exp")}`
                  levelups = results3.split(",")
                  exp, levels, tokens = levelups.map{|str| str.to_i}
                  monsterbattle.partner_plevel += levels
                  monsterbattle.partner_pexp += exp
                  monsterbattle.tokens_earned += tokens
                  monsterbattle.exp_earned += exp
                  if(battlestatus == "Win")
                     #Dreyore, and other items
                     results4 = `public/Resources/Code/monloot/calc #{monsterbattle.monster_plevel} #{monsterbattle.monster_loot}`
                     dreyoreGained = results4.to_i
                     monsterbattle.dreyore_earned += dreyoreGained
                     ore = Dreyore.find_by_name("Monster")
                     if(ore.cur == 0)
                        dreyoreGained = 0
                     elsif(ore.cur > 0 && ore.cur - dreyoreGained >= 0)
                        space = getCurLimit("Dreyore", current_user, "Number")
                        if(space > 0)
                           if(space < dreyoreGained)
                              dreyoreGained = space
                           end
                           ore.cur -= dreyoreGained
                           @ore = ore
                           @ore.save
                        else
                           dreyoreGained = 0
                        end
                     else
                        if(space > 0)
                           if(space < ore.cur)
                              dreyoreGained = space
                              ore.cur -= space
                           else
                              dreyoreGained = ore.cur
                              ore.cur = 0
                           end
                           @ore = ore
                           @ore.save
                        else
                           dreyoreGained = 0
                        end
                     end
                     current_user.pouch.dreyoreamount += dreyoreGained
                     @pouch = current_user.pouch
                     @pouch.save
                  end
                  partner.pexp += monsterbattle.exp_earned
               else
                  flash[:success] = "Sorry better luck next time"
               end
               monsterbattle.battleresult = battlestatus
               monsterbattle.battleover = true
               monsterbattle.ended_on = currentTime
               @partner = partner
               @partner.save
            end
            if(monsterbattle.battleresult == "Not-Started")
               monsterbattle.battleresult = "Started"
            end
            @monsterbattle = monsterbattle
            @monsterbattle.save
            redirect_to fight_monsterbattle_path(@monsterbattle.fight, @monsterbattle)
         else
            if(monsterbattle.battleover)
               flash[:error] = "This battle is already over!"
            end
            redirect_to root_path
         end
      end

      def showCommons(type)
         monsterbattleFound = Monsterbattle.find_by_id(getMonsterbattleParams("Id"))
         if(monsterbattleFound && current_user)
            removeTransactions
            #visitTimer(type, blogFound)
            #cleanupOldVisits
            @monsterbattle = monsterbattleFound
            if(type == "destroy")
               logged_in = current_user
               if(logged_in && ((logged_in.id == monsterbattleFound.partner.user_id) || logged_in.pouch.privilege == "Admin"))
                  if(logged_in.pouch.privilege == "Admin")
                     flash[:success] = "Battle was successfully removed!"
                     monsterbattleFound.fight.partner
                     partnerFound = monsterbattleFound.fight.partner
                     partnerFound.inbattle = false
                     @partner = partnerFound
                     @partner.save
                     @monsterbattle.destroy
                     redirect_to monsterbattles_path
                  else
                     if(monsterbattleFound.battleover)
                        flash[:success] = "Battle was successfully removed!"
                        @monsterbattle.destroy
                        redirect_to partner_fight_path(monsterbattleFound.fight.partner, monsterbattleFound.fight)
                     else
                        flash[:error] = "You can't delete an active battle!"
                        redirect_to root_path
                     end
                  end
               else
                  redirect_to root_path
               end
            end
         else
            redirect_to root_path
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
                  battles = Monsterbattle.order("started_on desc")
                  @monsterbattles = Kaminari.paginate_array(battles).page(getMonsterbattleParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "create")
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
                  partnerFound = Partner.find_by_id(params[:monsterbattle][:partner_id])
                  monsterFound = Monster.find_by_id(params[:monsterbattle][:monster_id])
                  if(logged_in && partnerFound && monsterFound && partnerFound.user_id == logged_in.id)
                     #Remember to eventually add some way for damage attributes to not show up on the first round
                     newBattle = Monsterbattle.new
                     newBattle.monster_id = monsterFound.id
                     newBattle.fight_id = partnerFound.fight.id
                     newBattle.started_on = currentTime
                     
                     #Stores the Partner physical stats
                     newBattle.partner_plevel = partnerFound.plevel
                     newBattle.partner_pexp = partnerFound.pexp
                     newBattle.partner_chp = partnerFound.chp
                     newBattle.partner_hp = partnerFound.hp
                     newBattle.partner_atk = partnerFound.atk
                     newBattle.partner_def = partnerFound.def
                     newBattle.partner_agility = partnerFound.agility
                     newBattle.partner_strength = partnerFound.strength

                     #Stores the Partner magical stats                     
                     newBattle.partner_mlevel = partnerFound.mlevel
                     newBattle.partner_mexp = partnerFound.mexp
                     newBattle.partner_cmp = partnerFound.cmp
                     newBattle.partner_mp = partnerFound.mp
                     newBattle.partner_matk = partnerFound.matk
                     newBattle.partner_mdef = partnerFound.mdef
                     newBattle.partner_magi = partnerFound.magi
                     newBattle.partner_mstr = partnerFound.mstr
                     
                     #Stores the Partner battle traits
                     newBattle.partner_lives = partnerFound.lives
                     newBattle.partner_activepet = partnerFound.activepet
                     partnerFound.inbattle = true
                     
                     #Stores the Monster physical stats
                     newBattle.monster_plevel = (monsterFound.level - 1)
                     newBattle.monster_chp = getMonsterStats(monsterFound, "HP")
                     newBattle.monster_hp = getMonsterStats(monsterFound, "HP")
                     newBattle.monster_atk = getMonsterStats(monsterFound, "Atk")
                     newBattle.monster_def = getMonsterStats(monsterFound, "Def")
                     newBattle.monster_agility = getMonsterStats(monsterFound, "Agi")
                     
                     #Stores the Monster magical stats
                     newBattle.monster_mlevel = (monsterFound.level - 1)
                     newBattle.monster_cmp = getMonsterStats(monsterFound, "MP")
                     newBattle.monster_mp = getMonsterStats(monsterFound, "MP")
                     newBattle.monster_matk = getMonsterStats(monsterFound, "Matk")
                     newBattle.monster_mdef = getMonsterStats(monsterFound, "Mdef")
                     newBattle.monster_magi = getMonsterStats(monsterFound, "Magi")
                     
                     #Stores the Monster battle traits
                     newBattle.monster_loot = getMonsterStats(monsterFound, "Loot")
                     newBattle.monster_exp = getMonsterStats(monsterFound, "Exp")
                     newBattle.monster_nightmare = getMonsterStats(monsterFound, "Nightmare")
                     newBattle.monster_shinycraze = getMonsterStats(monsterFound, "Shinycraze")
                     newBattle.monster_party = getMonsterStats(monsterFound, "Party")
                     newBattle.monster_mischief = monsterFound.mischief
                     
                     @partner = partnerFound
                     @monsterbattle = newBattle
                     
                     if(!logged_in.pouch.firstdreyore)
                        if(@monsterbattle.save)
                           @partner.save
                           flash[:success] = "#{@partner.name} is fighting #{@monsterbattle.monster.name}!"
                           redirect_to fight_monsterbattle_path(@monsterbattle.fight, @monsterbattle)
                        else
                           flash[:error] = "Battle was unable to be saved!"
                           redirect_to root_path
                        end
                     else
                        flash[:error] = "You haven't spent your newbie ore yet!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
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
            elsif(type == "battle")
               logged_in = current_user
               battleFound = Monsterbattle.find_by_id(params[:monsterbattle_id])
               if(logged_in && battleFound)
                  if(logged_in.id == battleFound.fight.partner.user_id)
                     getBattleCalc(battleFound)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
