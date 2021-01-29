module ShoutboxesHelper

   private
      def getShoutParams(type)
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
               if(logged_in && (logged_in.pouch.privilege == "Admin"))
                  removeTransactions
                  allBoxes = Shoutbox.order("id desc")
                  @shoutboxes = Kaminari.paginate_array(allBoxes).page(getBoxParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            end
         end
      end
end
