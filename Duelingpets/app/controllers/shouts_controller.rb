class ShoutsController < ApplicationController
   include ShoutsHelper

   def index
      mode "index"
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
end
