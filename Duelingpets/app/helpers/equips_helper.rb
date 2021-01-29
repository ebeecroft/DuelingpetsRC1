module EquipsHelper

   private
      def getEquipParams(type)
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
                  allEquips = Equip.order("id desc")
                  @equips = Kaminari.paginate_array(allEquips).page(getEquipParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "show")
               equipFound = Equip.find_by_id(getEquipParams("Id"))
               logged_in = current_user
               if(equipFound && logged_in)
                  if(logged_in.id == equipFound.partner.user_id)
                     @user = logged_in
                     @equip = equipFound
                     @partner = Partner.find_by_id(equipFound.partner_id)
                     slots = @equip.equipslots.all
                     @equipslots = Kaminari.paginate_array(slots).page(getEquipParams("Page")).per(1)
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
