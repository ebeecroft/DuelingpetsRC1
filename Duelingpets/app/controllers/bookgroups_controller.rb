class BookgroupsController < ApplicationController
   include BookgroupsHelper

   def index
      mode "index"
   end
end
