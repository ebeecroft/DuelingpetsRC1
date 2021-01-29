class InventoryslotsController < ApplicationController
   include InventoryslotsHelper
   include SlotparamsHelper

   def index
      mode "index"
   end

   def new
      mode "new"
   end

   def create
      mode "create"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def destroy
      mode "destroy"
   end

   def purchase
      mode "purchase"
   end
end
