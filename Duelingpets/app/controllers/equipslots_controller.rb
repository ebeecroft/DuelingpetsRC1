class EquipslotsController < ApplicationController
   include EquipslotsHelper
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

   def applyitem
      mode "applyitem"
   end

   def equippet
      mode "equippet"
   end

   def useitem
      mode "useitem"
   end
end
