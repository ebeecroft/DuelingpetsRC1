module WitemshelvesHelper

   private
      def getWitemshelfParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "WitemshelfId")
            value = params[:witemshelf_id]
         elsif(type == "Witemshelf")
            value = params.require(:witemshelf).permit(:name)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, itemshelf, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         newTransaction.attribute = "Itemshelf"
         newTransaction.content_type = itemshelf.name
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
                  allShelves = Witemshelf.all
                  @witemshelves = Kaminari.paginate_array(allShelves).page(getWitemshelfParams("Page")).per(1)
               else
                  redirect_to root_path
               end            
            elsif(type == "new" || type == "create")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Glitchy")
                  #Might be updated later
                  warehouseFound = Warehouse.find_by_id(1)
                  newShelf = warehouseFound.witemshelves.new
                  if(type == "create")
                     newShelf = warehouseFound.witemshelves.new(getWitemshelfParams("Witemshelf"))
                  end
                  @witemshelf = newShelf
                  @warehouse = warehouseFound
                  if(type == "create")
                     price = Fieldcost.find_by_name("Itemshelf")
                     if(@warehouse.treasury - price.amount >= 0)
                        if(@witemshelf.save)
                           @warehouse.treasury -= price.amount
                           @warehouse.save
                           economyTransaction("Sink", price.amount, @witemshelf, "Points")
                           flash[:success] = "Shelf #{@witemshelf.name} was successfully created."
                           redirect_to warehouses_path
                        else
                           render "new"
                        end
                     else
                        flash[:error] = "Insufficient funds to create an itemshelf!"
                        redirect_to warehouse_path(@warehouse)
                     end
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update" || type == "destroy")
               witemshelfFound = Witemshelf.find_by_name(getWitemshelfParams("Id"))
               if(witemshelfFound)
                  logged_in = current_user
                  if(logged_in && logged_in.pouch.privilege == "Glitchy")
                     @witemshelf = witemshelfFound
                     @warehouse = Warehouse.find_by_name(witemshelfFound.warehouse.name)
                     if(type == "update")
                        if(@witemshelf.update_attributes(getWitemshelfParams("Witemshelf")))
                           flash[:success] = "Witemshelf #{@witemshelf.name} was successfully updated."
                           redirect_to warehouses_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        cleanup = Fieldcost.find_by_name("Itemshelfcleanup")
                        if(@warehouse.treasury - cleanup.amount >= 0)
                           #Removes the shelf and decrements the owner's pouch
                           @warehouse.treasury -= cleanup.amount
                           @warehouse.save
                           economyTransaction("Sink", cleanup.amount, @witemshelf, "Points")
                           flash[:success] = "#{@witemshelf.name} was successfully removed."
                           @witemshelf.destroy
                           redirect_to warehouses_path
                        else
                           flash[:error] = "Insufficient points to remove the itemshelf!"
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
