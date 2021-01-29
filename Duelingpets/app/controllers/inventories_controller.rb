class InventoriesController < ApplicationController
   include InventoriesHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end
end
