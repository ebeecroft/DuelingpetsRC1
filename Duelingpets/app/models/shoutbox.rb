class Shoutbox < ApplicationRecord
   #Shoutbox related
   belongs_to :user, optional: true
   has_many :shouts, :foreign_key => "shoutbox_id", :dependent => :destroy
end
