class ArttagsController < ApplicationController
   include ArttagsHelper

   def index
      mode "index"
   end
   
   def addtag
      mode "addtag"
   end

   def removetag
      mode "removetag"
   end
end
