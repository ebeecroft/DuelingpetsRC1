class Colorscheme < ApplicationRecord
   #Colorscheme related
   has_many :userinfos
   has_one :webcontrol, :foreign_key => "daycolor_id"
   has_one :webcontrol, :foreign_key => "nightcolor_id"
   belongs_to :user, optional: true

   #Regex information for colorscheme
   VALID_NAME_REGEX = /\A[a-z][a-z][a-z0-9!-]+\z/i
   VALID_COLOR_REGEX = /\A[#][0-9a-f]+\z/i

   #Validates the colorscheme information upon submission
   validates :name, presence: true, format: {with: VALID_NAME_REGEX}, uniqueness: { case_sensitive: false}
   validates :description, presence: true
   validates :backgroundcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :headercolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :subheader1color, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :subheader2color, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :subheader3color, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :textcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navigationcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navigationlinkcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navigationhovercolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navigationhoverbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :onlinestatuscolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :profilecolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :profilehovercolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :profilehoverbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :sessioncolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navlinkcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navlinkhovercolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :navlinkhoverbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :explanationborder, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :explanationbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :explanheadercolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :explantextcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :errorfieldcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :errorcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :warningcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :notificationcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :successcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :editbuttoncolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :editbuttonbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :destroybuttoncolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :destroybuttonbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :submitbuttoncolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
   validates :submitbuttonbackgcolor, presence: true, length: {is: 7}, format: {with: VALID_COLOR_REGEX}
end
