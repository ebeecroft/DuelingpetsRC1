class PmrepliesController < ApplicationController
   include PmrepliesHelper

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
end
