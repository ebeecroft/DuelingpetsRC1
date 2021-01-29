class DonationboxesController < ApplicationController
   include DonationboxesHelper

   def index
      mode "index"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def retrieve
      mode "retrieve"
   end

   def refund
      mode "refund"
   end
end
