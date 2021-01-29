class RegistrationsController < ApplicationController
   include RegistrationsHelper

   def index
      mode "index"
   end

   def create
      mode "create"
   end

   def register
      mode "register"
   end

   def tokenfinder
      mode "tokenfinder"
   end

   def tokenpost
      mode "tokenpost"
   end

   def verify
      mode "verify"
   end

   def emailpost
      mode "emailpost"
   end

   def approve
      mode "approve"
   end

   def deny
      mode "deny"
   end

   def gate
      mode "gate"
   end
end
