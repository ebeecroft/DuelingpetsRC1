class Pouchtype < ApplicationRecord
   #Pouchtype
   #has_many :pouchslots, :foreign_key => "itemtype_id", :dependent => :destroy

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the pouchtype information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
