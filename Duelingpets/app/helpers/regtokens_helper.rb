module RegtokensHelper

   private
      def getRegtokenParams(type)
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
               removeTransactions
               if(current_user && current_user.pouch.privilege == "Admin")
                  allTokens = Regtoken.order("expiretime desc")
                  @regtokens = Kaminari.paginate_array(allTokens).page(getRegtokenParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "gentoken")
               if(current_user && current_user.pouch.privilege == "Admin")
                  newToken = Regtoken.new(params[:regtoken])
                  newToken.expiretime = 1.week.from_now.utc
                  newToken.token = SecureRandom.urlsafe_base64
                  @regtoken = newToken
                  @regtoken.save
                  flash[:success] = "Token was successfully created!"
                  redirect_to regtokens_path
               else
                  redirect_to root_path
               end
            elsif(type == "regentoken" || type == "destroy")
               tokenFound = Regtoken.find_by_id(getRegtokenParams("Id"))
               if(tokenFound)
                  logged_in = current_user
                  if(logged_in && logged_in.pouch.privilege == "Admin")
                     if(type == "regentoken")
                        tokenFound.token = SecureRandom.urlsafe_base64
                        tokenFound.expiretime = 1.week.from_now.utc
                        @regtoken = tokenFound
                        @regtoken.save
                        flash[:succes] = "Token was successfully reset!"
                     else
                        @regtoken = tokenFound
                        @regtoken.destroy
                        flash[:success] = "Token was successfully removed!"
                     end
                     redirect_to regtokens_path
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
