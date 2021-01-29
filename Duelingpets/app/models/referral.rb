class Referral < ApplicationRecord
   #Referrals related
   belongs_to :referred_by, :class_name => 'User', :foreign_key => 'referred_by_id', optional: true
   belongs_to :user, :class_name => 'User', :foreign_key => 'user_id', optional: true

   #Regex code for referrals
   VALID_VNAME_REGEX = /\A[a-z][a-z][a-z][a-z0-9-]+\z/i

   #Validates the referral information upon submission
   #validates :vname, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}
end
