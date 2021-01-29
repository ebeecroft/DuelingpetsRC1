module FieldcostsHelper

   private
      def getFieldcostParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "FieldcostId")
            value = params[:fieldcost_id]
         elsif(type == "Dragonhoard")
            value = params[:dragonhoard_id]
         elsif(type == "Fieldcost")
            value = params.require(:fieldcost).permit(:name, :amount, :econtype)
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
                  allFieldcosts = Fieldcost.order("updated_on desc, created_on desc")
                  @fieldcosts = Kaminari.paginate_array(allFieldcosts).page(getFieldcostParams("Page")).per(10)
               elsif(type == "new" || type == "create")
                  hoard = Dragonhoard.find_by_id(1)
                  newFieldcost = hoard.fieldcosts.new
                  if(type == "create")
                     newFieldcost = hoard.fieldcosts.new(getFieldcostParams("Fieldcost"))
                     newFieldcost.created_on = currentTime
                     newFieldcost.updated_on = currentTime
                  end

                  #Determines the type of baseinc the fieldcost gets incremented by
                  allBaseincs = Baseinc.order("created_on desc")
                  @baseincs = allBaseincs
                  @dragonhoard = hoard
                  @fieldcost = newFieldcost

                  if(type == "create")
                     if(@fieldcost.save)
                        flash[:success] = "#{@fieldcost.name} was successfully created."
                        redirect_to fieldcosts_path
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update")
                  fieldcostFound = fieldcost.find_by_id(getFieldcostParams("Id"))
                  if(fieldcostFound)
                     fieldcostFound.updated_on = currentTime

                     #Determines the type of baseinc the fieldcost gets incremented by
                     allBaseincs = Baseinc.order("created_on desc")
                     @baseincs = allBaseincs
                     @fieldcost = fieldcostFound
                     @dragonhoard = Dragonhoard.find_by_id(fieldcostFound.dragonhoard_id)
                     if(type == "update")
                        if(@fieldcost.update_attributes(getFieldcostParams("Fieldcost")))
                           flash[:success] = "Fieldcost #{@fieldcost.name} was successfully updated."
                           redirect_to fieldcosts_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               elsif(type == "increase" || type == "decrease")
                  fieldcostFound = Fieldcost.find_by_id(getFieldcostParams("FieldcostId"))
                  if(fieldcostFound)
                     pointchange = 0
                     if(type == "increase")
                        pointchange = fieldcostFound.amount + fieldcostFound.baseinc.amount
                     else
                        pointchange = fieldcostFound.amount - fieldcostFound.baseinc.amount
                     end

                     #Saves the change to fieldcosts amount
                     if(pointchange < 0)
                        flash[:error] = "You can't set points below 0!"
                        redirect_to root_path
                     else
                        hoard = Dragonhoard.find_by_id(fieldcostFound.dragonhoard_id)
                        basecost = hoard.basecost
                        if(hoard.treasury - basecost > -1)
                           #Decreases the points left in the dragonhoard
                           fieldcostFound.amount = pointchange
                           @fieldcost = fieldcostFound
                           @fieldcost.save
                           hoard.treasury -= basecost
                           @dragonhoard = hoard
                           @dragonhoard.save
                           flash[:success] = "Fieldcost #{fieldcost.name} was successfully increased/decreased!"
                           redirect_to fieldcosts_path
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
