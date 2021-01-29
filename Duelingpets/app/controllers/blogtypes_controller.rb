class BlogtypesController < ApplicationController
   include BlogtypesHelper

   def index
      mode "index"
   end
end
