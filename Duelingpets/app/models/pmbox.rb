class Pmbox < ApplicationRecord
   #Pmbox related
   belongs_to :user, optional: true
   has_many :pms, :foreign_key => "pmbox_id", :dependent => :destroy
end
