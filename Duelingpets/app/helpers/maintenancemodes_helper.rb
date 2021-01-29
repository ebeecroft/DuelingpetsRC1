module MaintenancemodesHelper

   private
      def getMaintenanceParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Maintenancemode")
            value = params.require(:maintenancemode).permit(:name, :maintenance_on)
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
            if(current_user && current_user.pouch.privilege = "Admin")
               if(type == "index")
                  removeTransactions
                  allModes = Maintenancemode.order("id").page(getMaintenanceParams("Page")).per(10)
                  @maintenancemodes = allModes
               elsif(type == "new" || type == "create")
                  newMaintenancemode = Maintenancemode.new
                  if(type == "create")
                     newMaintenancemode = Maintenancemode.new(getMaintenanceParams("Maintenancemode"))
                     newMaintenancemode.created_on = currentTime
                  end
                  @maintenancemode = newMaintenancemode
                  if(type == "create")
                     if(@maintenancemode.save)
                        flash[:success] = "#{@maintenancemode.name} was successfully created."
                        redirect_to maintenancemodes_url
                     else
                        render "new"
                     end
                  end
               elsif(type == "edit" || type == "update")
                  maintenancemodeFound = Maintenancemode.find_by_id(getMaintenanceParams("Id"))
                  if(maintenancemodeFound)
                     @maintenancemode = maintenancemodeFound
                     if(type == "update")
                        if(@maintenancemode.update_attributes(getMaintenanceParams("Maintenancemode")))
                           flash[:success] = "#{@maintenancemode.name} was successfully updated."
                           redirect_to maintenancemodes_url
                        else
                           render "edit"
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
