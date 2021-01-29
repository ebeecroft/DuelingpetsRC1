class BlogviewersController < ApplicationController
   include BlogviewersHelper

   def index
      mode "index"
   end
end
