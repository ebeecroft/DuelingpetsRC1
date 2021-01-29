class User < ApplicationRecord
   has_many :colorschemes, :foreign_key => "user_id", :dependent => :destroy
   has_many :ocs, :foreign_key => "user_id", :dependent => :destroy
   has_many :tags, :foreign_key => "user_id", :dependent => :destroy
   has_many :suggestions, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for user information
   has_one :pouch, :foreign_key => "user_id", :dependent => :destroy
   has_one :userinfo, :foreign_key => "user_id", :dependent => :destroy
   has_one :gameinfo, :foreign_key => "user_id", :dependent => :destroy
   has_many :economies, :foreign_key => "user_id", :dependent => :destroy
   has_many :suspendedtimelimits, :foreign_key => "user_id", :dependent => :destroy
   has_many :referrals, :foreign_key => "referred_by_id", :dependent => :destroy
   has_one :referral, :foreign_key => "user_id", :dependent => :destroy
   has_one :donationbox, :foreign_key => "user_id", :dependent => :destroy
   has_many :donors, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for communication
   has_one :shoutbox, :foreign_key => "user_id", :dependent => :destroy
   has_many :shouts, :foreign_key => "user_id", :dependent => :destroy
   has_one :pmbox, :foreign_key => "user_id", :dependent => :destroy
   has_many :pms, :foreign_key => "user_id", :dependent => :destroy
   has_many :pmreplies, :foreign_key => "user_id", :dependent => :destroy
   has_many :blogs, :foreign_key => "user_id", :dependent => :destroy
   has_many :blogreplies, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for music content
   has_many :jukeboxes, :foreign_key => "user_id", :dependent => :destroy
   has_many :mainsheets, :foreign_key => "user_id", :dependent => :destroy
   has_many :subsheets, :foreign_key => "user_id", :dependent => :destroy
   has_many :sounds, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for book content
   has_many :bookworlds, :foreign_key => "user_id", :dependent => :destroy
   has_many :books, :foreign_key => "user_id", :dependent => :destroy
   has_many :chapters, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for video content
   has_many :channels, :foreign_key => "user_id", :dependent => :destroy
   has_many :mainplaylists, :foreign_key => "user_id", :dependent => :destroy
   has_many :subplaylists, :foreign_key => "user_id", :dependent => :destroy
   has_many :movies, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for art content
   has_many :galleries, :foreign_key => "user_id", :dependent => :destroy
   has_many :mainfolders, :foreign_key => "user_id", :dependent => :destroy
   has_many :subfolders, :foreign_key => "user_id", :dependent => :destroy
   has_many :arts, :foreign_key => "user_id", :dependent => :destroy

   #Relationships for creature content
   has_many :elements, :foreign_key => "user_id", :dependent => :destroy
   has_many :creatures, :foreign_key => "user_id", :dependent => :destroy
   has_many :partners, :foreign_key => "user_id", :dependent => :destroy
   has_one :inventory, :foreign_key => "user_id", :dependent => :destroy
   has_many :items, :foreign_key => "user_id", :dependent => :destroy
   has_many :monsters, :foreign_key => "user_id", :dependent => :destroy

   #Regex code for managing the user section
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9-]+\z/i
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z0-9\d\-.]+\.[a-z0-9]+\z/i
   VALID_VNAME_REGEX = /\A[a-z][a-z][a-z][a-z0-9-]+\z/i

   #Validates the user information upon submission
   validates :imaginaryfriend, presence: true, format: {with: VALID_NAME_REGEX}
   validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
   validates :country, presence: true, format: {with: VALID_NAME_REGEX}
   validates :country_timezone, presence: true
   validates :birthday, presence: true
   validates :vname, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :login_id, presence: true, format: {with: VALID_VNAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :password, length: {minimum: 6}
   validates :password_confirmation, presence: true

   #Saving parameters that get changed
   has_secure_password
   before_save {|user| user.imaginaryfriend = user.imaginaryfriend.humanize}
   before_save {|user| user.email = user.email.downcase}

   #Overides the default parameters to use vname in place of the id code
   def to_param
      self.vname.parameterize
   end
end
