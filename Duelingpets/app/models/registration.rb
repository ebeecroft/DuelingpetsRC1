class Registration < ApplicationRecord
   #Regex code for managing the user section
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9]+\z/i
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z0-9\d\-.]+\.[a-z0-9]+\z/i
   VALID_VNAME_REGEX = /\A[a-z][a-z][a-z][a-z0-9-]+\z/i

   #Validates the user information upon submission
   validates :imaginaryfriend, presence: true, format: {with: VALID_NAME_REGEX}
   validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
   validates :country, presence: true, format: {with: VALID_NAME_REGEX}
   validates :country_timezone, presence: true
   validates :birthday, presence: true
   validates :message, presence: true
   validates :vname, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :login_id, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}

   #Saving parameters that get changed
   before_save {|registration| registration.imaginaryfriend = registration.imaginaryfriend.humanize}
   before_save {|registration| registration.email = registration.email.downcase}
end
