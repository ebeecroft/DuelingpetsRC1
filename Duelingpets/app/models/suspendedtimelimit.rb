class Suspendedtimelimit < ApplicationRecord
   #Suspendedtimelimits related
   belongs_to :to_user, :class_name => 'User', :foreign_key => 'user_id', optional: true
   belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user_id', optional: true

   #Validates the suspendedtimelimit information upon submission
   validates :reason, presence: true
   validates :pointfines, presence: true
   validates :emeralfines, presence: true
   validates :timelimit, presence: true
end
