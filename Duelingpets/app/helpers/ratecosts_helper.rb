module RatecostsHelper

   private
      def getRatecostParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "RatecostId")
            value = params[:ratecost_id]
         elsif(type == "Dragonhoard")
            value = params[:dragonhoard_id]
         elsif(type == "Ratecost")
            value = params.require(:ratecost).permit(:name, :amount, :econtype)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
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
                  allRatecosts = Ratecost.order("updated_on desc, created_on desc")
                  @ratecosts = Kaminari.paginate_array(allRatecosts).page(getRatecostParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  hoard = Dragonhoard.find_by_id(1)
                  newRatecost = hoard.ratecosts.new
                  if(type == "create")
                     newRatecost = hoard.ratecosts.new(getRatecostParams("Ratecost"))
                     newRatecost.created_on = currentTime
                     newRatecost.updated_on = currentTime
                  end

                  #Determines the type of baseinc the fieldcost gets incremented by
                  allBaserates = Baserate.order("created_on desc")
                  @baserates = allBaserates
                  @dragonhoard = hoard
                  @ratecost = newRatecost

                  if(type == "create")
                     if(@ratecost.save)
                        flash[:success] = "#{@ratecost.name} was successfully created."
                        redirect_to ratecosts_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update")
                  ratecostFound = Ratecost.find_by_id(getRatecostParams("Id"))
                  if(ratecostFound)
                     ratecostFound.updated_on = currentTime

                     #Determines the type of baseinc the fieldcost gets incremented by
                     allBaserates = Baserate.order("created_on desc")
                     @baserates = allBaserates
                     @ratecost = ratecostFound
                     @dragonhoard = Dragonhoard.find_by_id(ratecostFound.dragonhoard_id)
                     if(type == "update")
                        if(@ratecost.update_attributes(getRatecostParams("Ratecost")))
                           flash[:success] = "Ratecost #{@ratecost.name} was successfully updated."
                           redirect_to ratecosts_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               elsif(type == "increase" || type == "decrease")
                  ratecostFound = Ratecost.find_by_id(getRatecostParams("RatecostId"))
                  if(ratecostFound)
                     pointchange = 0
                     if(type == "increase")
                        pointchange = ratecostFound.amount + ratecostFound.baserate.amount
                     else
                        pointchange = ratecostFound.amount - ratecostFound.baserate.amount
                     end

                     #Saves the change to ratecosts amount
                     if(pointchange < 0)
                        flash[:error] = "You can't set points below 0!"
                        redirect_to root_path
                     else
                        hoard = Dragonhoard.find_by_id(ratecostFound.dragonhoard_id)
                        basecost = hoard.basecost
                        if(hoard.treasury - basecost > -1)
                           #Decreases the points left in the dragonhoard
                           ratecostFound.amount = pointchange
                           @ratecost = ratecostFound
                           @ratecost.save
                           hoard.treasury -= basecost
                           @dragonhoard = hoard
                           @dragonhoard.save
                           flash[:success] = "Ratecost #{ratecost.name} was successfully increased/decreased!"
                           redirect_to ratecosts_path
                        else
                           flash[:error] = "The Dragonhoard points are insufficient!"
                           redirect_to root_path
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               end
            else
               redirect_to root_path
            end
         end
      end
end
