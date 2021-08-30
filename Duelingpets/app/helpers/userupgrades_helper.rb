module UserupgradesHelper

   private
      def getUpgradeParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Upgrade")
            value = params.require(:userupgrade).permit(:name, :base, :baseinc, :price,
            :freecap, :membercap)
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
         newTransaction.content_type = "Upgrade"
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

      def getUpgrades(buytype, upgradetype, pouch, upgrade)
         #Add an additional slot later to switch to members
         userup = Userupgrade.find_by_id(upgrade)
         level = 0
         if(buytype == "Pouch")
            level = pouch.pouchslot.free1
            if(upgradetype == "Purchase")
               pouch.pouchslot.free1 += 1
               level = pouch.pouchslot.free1
            end
         elsif(buytype == "Gallery")
            level = pouch.pouchslot.free9
            if(upgradetype == "Purchase")
               pouch.pouchslot.free9 += 1
               level = pouch.pouchslot.free9
            end
         elsif(buytype == "Channel")
            level = pouch.pouchslot.free8
            if(upgradetype == "Purchase")
               pouch.pouchslot.free8 += 1
               level = pouch.pouchslot.free8
            end
         elsif(buytype == "Book")
            level = pouch.pouchslot.free7
            if(upgradetype == "Purchase")
               pouch.pouchslot.free7 += 1
               level = pouch.pouchslot.free7
            end
         elsif(buytype == "Jukebox")
            level = pouch.pouchslot.free6
            if(upgradetype == "Purchase")
               pouch.pouchslot.free6 += 1
               level = pouch.pouchslot.free6
            end
         elsif(buytype == "OC")
            level = pouch.pouchslot.free4
            if(upgradetype == "Purchase")
               pouch.pouchslot.free4 += 1
               level = pouch.pouchslot.free4
            end
         elsif(buytype == "Blog")
            level = pouch.pouchslot.free3
            if(upgradetype == "Purchase")
               pouch.pouchslot.free3 += 1
               level = pouch.pouchslot.free3
            end
         elsif(buytype == "Emerald")
            level = pouch.pouchslot.free2
            if(upgradetype == "Purchase")
               pouch.pouchslot.free2 += 1
               level = pouch.pouchslot.free2
            end
         elsif(buytype == "Dreyore")
            level = pouch.pouchslot.free5
            if(upgradetype == "Purchase")
               pouch.pouchslot.free5 += 1
               level = pouch.pouchslot.free5
            end
         end

         cost = 0
         #Determines the cost
         if(!userup.nil?)
            if(upgradetype == "Cost")
               upgrademax = userup.freecap
               if(level < upgrademax)
                  cost = userup.price * (level + 1)
               end
            elsif(upgradetype == "Limit" || upgradetype == "Max")
               cost = userup.base + (userup.baseinc * level)
               if(upgradetype == "Max")
                  cost = userup.freecap
               end
            elsif(upgradetype == "Purchase")
               @pouchslot = pouch.pouchslot
               @pouchslot.save
               cost = level
            end
         end
         return cost
      end

      def upgradeUser(buytype, upgrade)
         logged_in = current_user
         pouchFound = Pouch.find_by_id(params[:pouch_id])
         if((logged_in && pouchFound) && (logged_in.id == pouchFound.user_id))
            price = getUpgrades(buytype, "Cost", pouchFound, upgrade)
            message = "#{buytype}"
            if(price != 0 && (pouchFound.amount - price >= 0))
               if(logged_in.gameinfo.startgame)
                  #Prints out the object that was purchased
                  tax = (price * 0.05).round
                  pouchFound.amount -= price
                  message1 = "#{buytype}"
                  level = getUpgrades(buytype, "Purchase", pouchFound, upgrade)
                  message2 = "#{level}"
                  @pouch = pouchFound
                  @pouch.save
                  hoard = Dragonhoard.find_by_id(1)
                  hoard.profit += tax
                  @hoard = hoard
                  @hoard.save
                  economyTransaction("Sink", price - tax, logged_in.id, "Points") #Might have emeralds later
                  economyTransaction("Tax", tax, logged_in.id, "Points")
                  flash[:success] = "Your " + message1 + " level is now: " + message2
                  redirect_to user_path(@pouch.user.vname)
               else
                  flash[:error] = "The game hasn't started yet you silly squirrel. LOL!"
                  redirect_to edit_gameinfo_path(@user.gameinfo)
               end
            else
               if(price == 0)
                  message = "You have already upgraded this feature to the max."
               else
                  message = "Insufficient points to pay for this upgrade!"
               end
               flash[:error] = message
               redirect_to user_path(pouchFound.user.vname)
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
               if(current_user && current_user.pouch.privilege == "Admin")
                  removeTransactions
                  allUpgrades = Userupgrade.order("id asc")
                  @userupgrades = Kaminari.paginate_array(allUpgrades).page(getUpgradeParams("Page")).per(10)
               end
            elsif(type == "new" || type == "create")
               if(current_user && current_user.pouch.privilege == "Admin")
                  newUpgrade = Userupgrade.new
                  if(type == "create")
                     newUpgrade = Userupgrade.new(getUpgradeParams("Upgrade"))
                  end
                  @userupgrade = newUpgrade

                  if(type == "create")
                     if(@userupgrade.save)
                        flash[:success] = "Upgrade #{@userupgrade.name} was successfully created."
                        redirect_to userupgrades_path
                     else
                        render "new"
                     end
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  upgradeFound = Userupgrade.find_by_id(getUpgradeParams("Id"))
                  if(upgradeFound)
                     @userupgrade = upgradeFound
                     if(type == "update")
                        if(@userupgrade.update_attributes(getUpgradeParams("Upgrade")))
                           flash[:success] = "Upgrade #{@userupgrade.name} was successfully updated."
                           redirect_to userupgrades_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               end
            elsif(type == "upgrade")
               buytype = params[:buyname]
               upgrade = params[:upnumber]
               upgradeUser(buytype, upgrade)
            end
         end
      end
end
