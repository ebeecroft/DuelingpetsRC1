module EconomiesHelper

   private
      def getEconomyParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Economy")
            #value = params.require(:economy).permit(:name, :econtype, :content_type, :amount)
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
                  allEconomies = Economy.order("created_on desc")
                  @economies = Kaminari.paginate_array(allEconomies).page(getEconomyParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
