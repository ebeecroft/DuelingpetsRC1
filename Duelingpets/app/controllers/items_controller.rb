class ItemsController < ApplicationController
   include ItemsHelper
   include SlotparamsHelper

   def index
      mode "index"
   end

   def show
      mode "show"
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

   def review
      mode "review"
   end

   def approve
      mode "approve"
   end

   def deny
      mode "deny"
   end

   def list
      mode "list"
   end

   def junkdealer
      mode "junkdealer"
   end

   def yesitem
      mode "yesitem"
   end

   def noitem
      mode "noitem"
   end

   def choose
      mode "choose"
   end

   def choosepost
      mode "choosepost"
   end
end
