class Oc < ApplicationRecord
   #Ocs related
   belongs_to :user, optional: true
   belongs_to :bookgroup, optional: true
   belongs_to :gviewer, optional: true
   has_one :octag, :foreign_key => "oc_id", :dependent => :destroy

   #Uploader section
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :image, ImageUploader
   mount_uploader :voiceogg, VoiceoggUploader
   mount_uploader :voicemp3, Voicemp3Uploader

   #Regex for title
   VALID_TITLE_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the oc information upon submission
   validates :name, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :nickname, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :species, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :alignment, presence: true, format: {with: VALID_TITLE_REGEX}
   validates :age, presence: true, format: {with: VALID_VALUE_REGEX}
   validates :description, presence: true
   validates :personality, presence: true
   validates :likesanddislikes, presence: true
   validates :backgroundandhistory, presence: true
   validates :relatives, presence: true
   validates :family, presence: true
   validates :friends, presence: true
   validates :world, presence: true
   validates :alliance, presence: true
   validates :elements, presence: true
   validates :appearance, presence: true
   validates :clothing, presence: true
   validates :accessories, presence: true
end
