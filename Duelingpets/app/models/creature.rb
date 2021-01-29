class Creature < ApplicationRecord
   #Creatures related
   belongs_to :user, optional: true
   belongs_to :creaturetype, optional: true
   belongs_to :element, optional: true
   has_many :partners, :foreign_key => "creature_id", :dependent => :destroy

   #Uploader section
   mount_uploader :image, ImageUploader
   mount_uploader :activepet, ActivepetUploader
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :voiceogg, VoiceoggUploader
   mount_uploader :voicemp3, Voicemp3Uploader

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the blog information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
   validates :hp, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :atk, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :def, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :agility, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :strength, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :mp, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :matk, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :mdef, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :magi, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :mstr, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :hunger, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :thirst, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :fun, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :lives, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :rarity, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldcost, presence: true, format: { with: VALID_VALUE_REGEX}

   #Overides the default parameters to use vname in place of the id code
   def to_param
      self.name.parameterize
   end
end
