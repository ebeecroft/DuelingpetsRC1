class DreyoresController < ApplicationController
   include DreyoresHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def addore
      mode "addore"
   end
end
