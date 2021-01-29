class Dragonhoard < ApplicationRecord
   #Pages that require dragonhoards
   has_many :fieldcosts, :foreign_key => "dragonhoard_id", :dependent => :destroy
   has_many :ratecosts, :foreign_key => "dragonhoard_id", :dependent => :destroy
   has_many :dreyores, :foreign_key => "dragonhoard_id", :dependent => :destroy

   #Uploader section
   mount_uploader :dragonimage, DragonimageUploader
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex information for dragonhoard
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i
   VALID_DOUBLE_REGEX = /\A[0-9]+[.][0-9]+\z/i

   #Validation section
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :basecost, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :baserate, presence: true, format: {with: VALID_DOUBLE_REGEX}
   validates :message, presence: true
end
