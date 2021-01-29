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

      def editCommons(type)
         witemshelfFound = Witemshelf.find_by_name(getWitemshelfParams("Id"))
         if(witemshelfFound)
            logged_in = current_user
            if(logged_in && logged_in.pouch.privilege == "Glitchy")
               @witemshelf = witemshelfFound
               @warehouse = Warehouse.find_by_name(witemshelfFound.warehouse.name)
               if(type == "update")
                  if(@witemshelf.update_attributes(getWitemshelfParams("Witemshelf")))
                     flash[:success] = "Witemshelf #{@witemshelf.name} was successfully updated."
                     redirect_to witemshelves_path
                  else
                     render "edit"
                  end
               end
            else
               redirect_to root_path
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
                     if(@witemshelf.save)
                        flash[:success] = "Shelf #{@witemshelf.name} was successfully created."
                        redirect_to witemshelves_path
                     else
                        render "new"
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
                           redirect_to witemshelves_path
                        else
                           render "edit"
                        end
                     elsif(type == "destroy")
                        #Eventually consider adding a sink to this
                        @witemshelf.destroy
                        flash[:success] = "#{@item.name} was successfully removed."
                        redirect_to witemshelves_path
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
