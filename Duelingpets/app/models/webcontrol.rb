class Webcontrol < ApplicationRecord
   #Webcontrol related
   belongs_to :daycolor, :class_name => 'Colorscheme', :foreign_key => 'daycolor_id', optional: true
   belongs_to :nightcolor, :class_name => 'Colorscheme', :foreign_key => 'nightcolor_id', optional: true

   #Uploader section
   mount_uploader :banner, BannerUploader
   mount_uploader :mascot, MascotUploader
   mount_uploader :favicon, FaviconUploader
   mount_uploader :criticalogg, CriticaloggUploader
   mount_uploader :criticalmp3, Criticalmp3Uploader
   mount_uploader :betaogg, BetaoggUploader
   mount_uploader :betamp3, Betamp3Uploader
   mount_uploader :grandogg, GrandoggUploader
   mount_uploader :grandmp3, Grandmp3Uploader
   mount_uploader :ogg, OggUploader
   mount_uploader :mp3, Mp3Uploader
   mount_uploader :creationogg, CreationoggUploader
   mount_uploader :creationmp3, Creationmp3Uploader
   mount_uploader :missingpageogg, MissingpageoggUploader
   mount_uploader :missingpagemp3, Missingpagemp3Uploader
   mount_uploader :maintenanceogg, MaintenanceoggUploader
   mount_uploader :maintenancemp3, Maintenancemp3Uploader
end
