class BookworldsController < ApplicationController
   include BookworldsHelper

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

   def list
      mode "list"
   end

   def increase
      mode "increase"
   end

   def decrease
      mode "decrease"
   end
end
