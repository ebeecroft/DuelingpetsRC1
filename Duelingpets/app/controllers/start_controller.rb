class StartController < ApplicationController
   include StartHelper

   def home
      mode "home"
   end

   def aboutus
      mode "aboutus"
   end

   def privacy
      mode "privacy"
   end

   def sitemap
      mode "sitemap"
   end

   def contact
      mode "contact"
   end

   def verify
      mode "verify"
   end

   def verify2
      mode "verify2"
   end

   def activeusers
      mode "activeusers"
   end

   def hubworld
      mode "hubworld"
   end

   def admincontrols
      mode "admincontrols"
   end

   def keymastercontrols
      mode "keymastercontrols"
   end

   def reviewercontrols
      mode "reviewercontrols"
   end
end
