class UserupgradesController < ApplicationController
   include UserupgradesHelper

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

   def upgrade
      mode "upgrade"
   end
end
