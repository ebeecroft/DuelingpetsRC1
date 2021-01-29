class ShoutboxesController < ApplicationController
   include ShoutboxesHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end
end
