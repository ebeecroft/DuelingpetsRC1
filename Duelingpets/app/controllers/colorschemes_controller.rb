class ColorschemesController < ApplicationController
   include ColorschemesHelper

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

   def list
      mode "list"
   end

   def undo
      mode "undo"
   end

   def activatecolor
      mode "activatecolor"
   end
end
