class EquipsController < ApplicationController
   include EquipsHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end
end
