module InventoriesHelper

   private
      def getInventoryParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
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
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allInventories = Inventory.order("id desc")
                  @inventories = Kaminari.paginate_array(allInventories).page(getInventoryParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "show")
               inventoryFound = Inventory.find_by_id(getInventoryParams("Id"))
               logged_in = current_user
               if(inventoryFound && logged_in)
                  if(logged_in.id == inventoryFound.user_id)
                     @user = logged_in
                     allActions = Itemaction.all
                     actions = allActions.select{|action| action.name == "Discard" || action.name == "Equip"}
                     @actiongroup = actions
                     @inventory = inventoryFound
                     slots = @inventory.inventoryslots.all
                     @inventoryslots = Kaminari.paginate_array(slots).page(getInventoryParams("Page")).per(1)
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
