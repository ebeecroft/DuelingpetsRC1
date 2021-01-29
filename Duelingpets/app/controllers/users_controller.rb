class UsersController < ApplicationController
   include UsersHelper

   def index
      mode "index"
   end

   def show
      mode "show"
   end

   def edit
      mode "edit"
   end

   def update
      mode "update"
   end

   def destroy
      mode "destroy"
   end

   def music
      mode "music"
   end

   def muteAudio
      mode "muteAudio"
   end

   def extractore
      mode "extractore"
   end

   def controlsOn
      mode "controlsOn"
   end

   def disableshoutbox
      mode "disableshoutbox"
   end

   def disablepmbox
      mode "disablepmbox"
   end
end
