class Itemaction < ApplicationRecord
   #Validates the itemaction parameters
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9-]+\z/i
   validates :name, presence: true, format: { with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}

   #Overides the default parameters to use name in place of the id code
   def to_param
      self.name.parameterize
   end
end
