module WpetdensHelper

   private
      def getWpetdenParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "WpetdenId")
            value = params[:wpetden_id]
         elsif(type == "Wpetden")
            value = params.require(:wpetden).permit(:name)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def economyTransaction(type, points, petden, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Petden"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = petden.name
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
            if(type == "index")
               removeTransactions
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Glitchy")
                  allShelves = Wpetden.all
                  @wpetdens = Kaminari.paginate_array(allDens).page(getWpetdenParams("Page")).per(1)
               else
                  redirect_to root_path
               end            
            elsif(type == "new" || type == "create")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Glitchy")
                  #Might be updated later
                  warehouseFound = Warehouse.find_by_id(1)
                  newDen = warehouseFound.wpetdens.new
                  if(type == "create")
                     newDen = warehouseFound.wpetdens.new(getWpetdenParams("Wpetden"))
                  end
                  @wpetden = newDen
                  @warehouse = warehouseFound
                  if(type == "create")
                     price = Fieldcost.find_by_name("Petden")
                     if(@warehouse.treasury - price.amount >= 0)
                        if(@wpetden.save)
                           @warehouse.treasury -= price.amount
                           @warehouse.save
                           economyTransaction("Sink", price.amount, @wpetden, "Points")
                           flash[:success] = "Den #{@wpetden.name} was successfully created."
                           redirect_to warehouses_path
                        else
                           render "new"
                        end
                     else
                        flash[:error] = "Insufficient funds to create a petden!"
                        redirect_to warehouse_path(@warehouse)
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               wpetdenFound = Wpetden.find_by_name(getWpetdenParams("Id"))
               if(wpetdenFound)
                  logged_in = current_user
                  if(logged_in && logged_in.pouch.privilege == "Glitchy")
                     @wpetden = wpetdenFound
                     @warehouse = Warehouse.find_by_name(wpetdenFound.warehouse.name)
                     if(type == "update")
                        if(@wpetden.update_attributes(getWpetdenParams("Wpetden")))
                           flash[:success] = "Wpetden #{@wpetden.name} was successfully updated."
                           redirect_to warehouses_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        cleanup = Fieldcost.find_by_name("Petdencleanup")
                        if(@warehouse.treasury - cleanup.amount >= 0)
                           #Removes the den and decrements the owner's pouch
                           @warehouse.treasury -= cleanup.amount
                           @warehouse.save
                           economyTransaction("Sink", cleanup.amount, @wpetden, "Points")
                           flash[:success] = "#{@wpetden.name} was successfully removed."
                           @wpetden.destroy
                           redirect_to warehouses_path
                        else
                           flash[:error] = "Insufficient points to remove the petden!"
                           redirect_to warehouses_path
                        end
                     end                     
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
