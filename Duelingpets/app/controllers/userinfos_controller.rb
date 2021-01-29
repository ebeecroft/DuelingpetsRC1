class UserinfosController < ApplicationController
   include UserinfosHelper
   include BookgroupretrievalHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end
end
