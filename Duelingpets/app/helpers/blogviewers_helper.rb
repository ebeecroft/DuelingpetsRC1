module BlogviewersHelper

   private
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
                  allBlogs = Blogviewer.order("id asc")
                  @blogviewers = allBlogs
               else
                  redirect_to root_path
               end
            end
         end
      end
end
