class ReferralsController < ApplicationController
   include ReferralsHelper

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

   def discoveredit
      mode "discoveredit"
   end
end
