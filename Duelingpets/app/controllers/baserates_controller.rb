class BaseratesController < ApplicationController
   include BaseratesHelper

   def index
      mode "index"
   end
end
