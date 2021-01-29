class FightsController < ApplicationController
   include FightsHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end
end
