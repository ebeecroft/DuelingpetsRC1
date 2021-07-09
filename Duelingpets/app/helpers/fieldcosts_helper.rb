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
            value = params.require(:fieldcost).permit(:name, :econtype)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, field, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         newTransaction.econattr = "Fieldcost"
         newTransaction.content_type = field.name
         newTransaction.econtype = type
         newTransaction.amount = points
         #Currency can be either Points, Emeralds or Skildons
         newTransaction.currency = currency
         newTransaction.dragonhoard_id = 1
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
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
                     hoard = Dragonhoard.find_by_id(1)
                     price = ((hoard.fieldprice * 0.35) + (6 * newFieldcost.baseinc.amount)).round
                     if(hoard.treasury - price >= 0)
                        if(@fieldcost.save)
                           hoard.treasury -= price
                           @hoard = hoard
                           @hoard.save
                           economyTransaction("Sink", price, fieldFound, "Points")
                           flash[:success] = "#{@fieldcost.name} was successfully created."
                           redirect_to dragonhoards_path
                        else
                           render "new"
                        end
                     else
                        flash[:error] = "Insufficient funds to create a new field!"
                        redirect_to dragonhoards_path
                     end
                  end
               elsif(type == "edit" || type == "update")
                  fieldcostFound = Fieldcost.find_by_id(getFieldcostParams("Id"))
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
                           redirect_to dragonhoards_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               elsif(type == "increase" || type == "decrease")
                  fieldFound = Fieldcost.find_by_id(getFieldcostParams("FieldcostId"))
                  if(fieldFound)
                     #Fieldprice * fixed rate + Constant * baseinc of that field
                     price = ((fieldFound.amount * 0.35) + (6 * fieldFound.baseinc.amount)).round
                     hoard = Dragonhoard.find_by_id(1)
                     if(hoard.treasury - price >= 0)
                        change = fieldFound.amount + fieldFound.baseinc.amount
                        if(type == "decrease")
                           change = fieldFound.amount - fieldFound.baseinc.amount
                        end
                        if(change >= 0)
                           #Might change this one later to deal with emeralds
                           hoard.treasury -= price
                           @hoard = hoard
                           @hoard.save
                           fieldFound.amount = change
                           @fieldcost = fieldFound
                           @fieldcost.save
                           economyTransaction("Sink", price, fieldFound, "Points")
                           if(type == "increase")
                              flash[:success] = "Field #{@fieldcost.name} was incremented!"
                           else
                              flash[:success] = "Field #{@fieldcost.name} was decremented!"
                           end
                        else
                           flash[:error] = "Fieldcosts can never be below 0!"
                        end
                        redirect_to dragonhoards_path
                     else
                        flash[:error] = "Funds too low to increment or decrement the field #{fieldFound.name}!"
                        redirect_to dragonhoards_path
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
