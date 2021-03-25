class Monster < ApplicationRecord
   #Monsters related
   belongs_to :user, optional: true
   belongs_to :monstertype, optional: true
   belongs_to :element, optional: true
   has_many :monsterbattles, :foreign_key => "monster_id", :dependent => :destroy

   #Uploader section
   mount_uploader :image, ImageUploader
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[0-9]+\z/i

   #Validates the monster information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
   validates :mischief, presence: true, format: {with: VALID_NAME_REGEX}
   validates :hp, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :atk, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :def, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :agility, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :mp, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :matk, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :mdef, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :magi, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :exp, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :nightmare, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :shinycraze, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :party, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :rarity, presence: true, format: { with: VALID_VALUE_REGEX}

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
