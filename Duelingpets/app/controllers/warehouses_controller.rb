class WarehousesController < ApplicationController
   include WarehousesHelper
   include WarehouseretrievalHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def buyitem
      mode "buyitem"
   end

   def buypet
      mode "buypet"
   end

   def withdraw
      mode "withdraw"
   end

   def tsetup
      mode "tsetup"
   end

   def transfer
      mode "transfer"
   end

   def transferpost
      mode "transferpost"
   end
end
