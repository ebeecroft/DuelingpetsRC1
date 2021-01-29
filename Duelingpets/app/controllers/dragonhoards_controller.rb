class DragonhoardsController < ApplicationController
   include DragonhoardsHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def withdraw
      mode "withdraw"
   end

   def createemeralds
      mode "createemeralds"
   end

   def buyemeralds
      mode "buyemeralds"
   end

   def convertpoints
      mode "convertpoints"
   end

   def transfer
      mode "transfer"
   end

   def waretransfer
      mode "waretransfer"
   end

   def warepost
      mode "warepost"
   end

   def itemmarket
      mode "itemmarket"
   end

   def petmarket
      mode "petmarket"
   end

   def buyitem
      mode "buyitem"
   end

   def buypet
      mode "buypet"
   end
end
