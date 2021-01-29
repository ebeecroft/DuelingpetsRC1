class RegtokensController < ApplicationController
   include RegtokensHelper

   def index
      mode "index"
   end
   
   def destroy
      mode "destroy"
   end
   
   def gentoken
      mode "gentoken"
   end

   def regentoken
      mode "regentoken"
   end
end
