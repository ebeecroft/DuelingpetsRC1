module ElementchartsHelper

   private
      def getElementchartParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "ElementchartId")
            value = params[:elementchart_id]
         elsif(type == "Element")
            value = params[:element_id]
         elsif(type == "Elementchart")
            value = params.require(:elementchart).permit(:sweak_id, :eweak_id, :sstrength_id, :estrength_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def editCommons(type)
         elementchartFound = Elementchart.find_by_id(getElementchartParams("Id"))
         if(elementchartFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == elementchartFound.element.user_id) || logged_in.pouch.privilege == "Admin"))
               @elementchart = elementchartFound
               @element = Element.find_by_id(elementchartFound.element.id)
               elements = Element.all
               @elements = elements
               if(type == "update")
                  if(@elementchart.update_attributes(getElementchartParams("Elementchart")))
                     flash[:success] = "Elementchart was successfully updated."
                     if(logged_in.pouch.privilege == "Admin")
                        redirect_to elementcharts_path
                     else
                        redirect_to user_element_path(@element.user, @element)
                     end
                  else
                     render "edit"
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
         end
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
                  allCharts = Elementchart.order("id desc")
                  @elementcharts = Kaminari.paginate_array(allCharts).page(getElementchartParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  elementMode = Maintenancemode.find_by_id(10)
                  if(allMode.maintenance_on || elementMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/elements/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            end
         end
      end
end
