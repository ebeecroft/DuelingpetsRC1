class Partner < ApplicationRecord
   #Partners related
   has_one :equip, :foreign_key => "partner_id", :dependent => :destroy
   has_one :fight, :foreign_key => "partner_id", :dependent => :destroy
   belongs_to :user, optional: true
   belongs_to :creature, optional: true

   #Regex for name
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i

   #Validates the partner information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}
   validates :description, presence: true
end
