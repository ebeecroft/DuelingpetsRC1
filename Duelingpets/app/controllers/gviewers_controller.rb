class GviewersController < ApplicationController
   include GviewersHelper

   def index
      mode "index"
   end
end
