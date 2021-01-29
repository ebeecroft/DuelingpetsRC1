class Userinfo < ApplicationRecord
   #Userinfo related
   belongs_to :user, optional: true
   belongs_to :daycolor, :class_name => 'Colorscheme', :foreign_key => 'daycolor_id', optional: true
   belongs_to :nightcolor, :class_name => 'Colorscheme', :foreign_key => 'nightcolor_id', optional: true
   belongs_to :bookgroup, optional: true

   #Uploader section
   mount_uploader :miniavatar, MiniavatarUploader
   mount_uploader :avatar, AvatarUploader
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Validation for userinfo
   validates :info, presence: true
end
