class SessionsController < ApplicationController
   include SessionsHelper

   def destroy
      mode "destroy"
   end

   def login
      mode "login"
   end

   def loginpost
      mode "loginpost"
   end

   def recover
      mode "recover"
   end

   def recoverpost
      mode "recoverpost"
   end

   def altemail
      mode "altemail"
   end

   def altemailpost
      mode "altemailpost"
   end

   def activate
      mode "activate"
   end

   def activatepost
      mode "activatepost"
   end

   def extendtime
      mode "extendtime"
   end

   def extendtimepost
      mode "extendtimepost"
   end

   def findlogin
      mode "findlogin"
   end

   def findloginpost
      mode "findloginpost"
   end
end
