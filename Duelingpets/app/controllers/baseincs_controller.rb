class BaseincsController < ApplicationController
   include BaseincsHelper

   def index
      mode "index"
   end
end
