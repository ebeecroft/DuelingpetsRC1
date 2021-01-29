class DonorsController < ApplicationController
   include DonorsHelper

   def index
      mode "index"
   end

   def new
      mode "new"
   end

   def create
      mode "create"
   end

   def mydonors
      mode "mydonors"
   end
end
