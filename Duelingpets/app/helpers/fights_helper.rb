module FightsHelper

   private
      def getFightParams(type)
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
                  allFights = Fight.order("id desc")
                  @fights = Kaminari.paginate_array(allFights).page(getFightParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "show")
               fightFound = Fight.find_by_id(getFightParams("Id"))
               logged_in = current_user
               if(fightFound && logged_in)
                  if(logged_in.id == fightFound.partner.user_id)
                     @user = logged_in
                     @fight = fightFound
                     @partner = Partner.find_by_id(fightFound.partner_id)
                     battles = @fight.monsterbattles.all
                     @monsterbattles = Kaminari.paginate_array(battles).page(getFightParams("Page")).per(10)
                  end
               else
                  redirect_to root_path
               end
            end
         end
      end
end
