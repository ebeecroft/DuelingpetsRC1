module DreyoresHelper

   private
      def getDreyoreParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "DreyoreId")
            value = params[:dreyore_id]
         elsif(type == "Dragonhoard")
            value = params[:dragonhoard_id]
         elsif(type == "Dreyore")
            value = params.require(:dreyore).permit(:name, :change, :cap, :baseinc)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, dreyore, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         newTransaction.attribute = "Dreyore"
         newTransaction.content_type = dreyore.name
         newTransaction.econtype = type
         newTransaction.amount = points
         #Currency can be either Points, Emeralds or Skildons
         newTransaction.currency = currency
         newTransaction.dragonhoard_id = 1
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def getDreyterriumLeft
         allPouches = Pouch.all
         newDreyterrium = allPouches.select{|pouch| pouch.dreyterriumamount > 0 && pouch.firstdreyterrium}
         value = newDreyterrium.count
         return value
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            logged_in = current_user
            if(logged_in && logged_in.pouch.privilege == "Glitchy")
               if(type == "index")
                  removeTransactions
                  allDreyores = Dreyore.order("updated_on desc, created_on desc")
                  @dreyores = Kaminari.paginate_array(allDreyores).page(getDreyoreParams("Page")).per(10)
               elsif(type == "edit" || type == "update")
                  dreyoreFound = Dreyore.find_by_id(getDreyoreParams("Id"))
                  if(dreyoreFound)
                     dreyoreFound.updated_on = currentTime
                     @dreyore = dreyoreFound
                     @dragonhoard = Dragonhoard.find_by_id(dreyoreFound.dragonhoard_id)
                     if(type == "update")
                        if(@dreyore.update_attributes(getDreyoreParams("Dreyore")))
                           flash[:success] = "Dreyore #{@dreyore.name} was successfully updated."
                           redirect_to ratecosts_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               elsif(type == "addore")
                  dreyoreFound = Dreyore.find_by_id(getDreyoreParams("DreyoreId"))
                  if(dreyoreFound)
                     if((dreyoreFound.cur + dreyoreFound.baseinc) <= dreyoreFound.cap)
                        if((dreyoreFound.name == "Newbie" && getDreyterriumLeft == 0) || dreyoreFound.name == "Monster")
                           dreyoreFound.cur += dreyoreFound.baseinc
                           if(dreyoreFound.extracted != 0)
                              dreyoreFound.extracted = 0
                           end
                           fieldcost = Fieldcost.find_by_name("Dreyterriumbase")
                           if(dreyoreFound.price != fieldcost.amount)
                              dreyoreFound.price = fieldcost.amount
                           end
                           #Fieldprice * fixed rate + Constant * baseinc of that field
                           price = ((dreyoreFound.cur * 0.35) + (8 * dreyoreFound.baseinc)).round
                           hoard = dreyoreFound.dragonhoard
                           if(hoard.treasury - price >= 0)
                              hoard.treasury -= price
                              @hoard = hoard
                              @hoard.save
                              @dreyore = dreyoreFound
                              @dreyore.save
                              economyTransaction("Sink", price, dreyoreFound, "Points")
                              flash[:success] = "#{dreyoreFound.name} was successfully increased!"
                              redirect_to dragonhoards_path
                           else
                              flash[:error] = "Funds too low to add Dreyore to #{dreyoreFound.name} ore!"
                              redirect_to dragonhoards_path
                           end
                        else
                           flash[:error] = "There is still dreyore left in the players pouches!"
                           redirect_to dragonhoards_path
                        end
                     else
                        flash[:error] = "Dreyore #{dreyore.name} is at the max!"
                        redirect_to dragonhoards_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            else
               redirect_to root_path
            end
         end
      end
end
