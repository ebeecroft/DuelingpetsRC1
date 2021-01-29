class WebcontrolsController < ApplicationController
   include WebcontrolsHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def missingpage
      mode "missingpage"
   end
end
