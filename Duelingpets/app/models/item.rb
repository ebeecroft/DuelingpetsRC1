class Item < ApplicationRecord
   #Items related
   belongs_to :user, optional: true
   belongs_to :itemtype, optional: true

   #Uploader section
   mount_uploader :itemart, ItemartUploader

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_VALUE_REGEX = /\A[-]?[0-9]+\z/i

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
   validates :durability, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :rarity, presence: true, format: { with: VALID_VALUE_REGEX}
   validates :emeraldcost, presence: true, format: { with: VALID_VALUE_REGEX}

   #Overides the default parameters to use vname in place of the id code
   def to_param
      self.name.parameterize
   end
end
