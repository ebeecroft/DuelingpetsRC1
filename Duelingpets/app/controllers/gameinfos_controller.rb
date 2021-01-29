class GameinfosController < ApplicationController
   include GameinfosHelper

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
