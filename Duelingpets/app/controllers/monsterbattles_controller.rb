class MonsterbattlesController < ApplicationController
   include MonsterbattlesHelper
   include EconomyretrievalHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end

   def create
      mode "create"
   end

   def destroy
      mode "destroy"
   end

   def battle
      mode "battle"
   end
end
