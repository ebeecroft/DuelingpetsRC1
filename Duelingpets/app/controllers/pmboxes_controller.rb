class PmboxesController < ApplicationController
   include PmboxesHelper

   def index
      mode "index"
   end

   def inbox
      mode "inbox"
   end

   def outbox
      mode "outbox"
   end
end
