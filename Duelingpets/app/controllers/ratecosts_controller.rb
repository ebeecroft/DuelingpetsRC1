class RatecostsController < ApplicationController
   include RatecostsHelper

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

   def increment
      mode "increment"
   end

   def decrement
      mode "decrement"
   end
end
