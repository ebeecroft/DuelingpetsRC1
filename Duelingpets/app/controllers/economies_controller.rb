class EconomiesController < ApplicationController
   include EconomiesHelper

   def index
      mode "index"
   end
end
