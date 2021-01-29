module ColorschemeretrievalHelper

   private
      def getColorAttribute(attribute)
         value = ""
         if(current_user)
            #Eventually switch to choice night or day
            if(current_user.userinfo.nightvision)
               if(!current_user.userinfo.nightcolor_id.nil?)
                  usercolor = Colorscheme.find_by_id(current_user.userinfo.nightcolor_id)
               else
                  usercolor = Colorscheme.find_by_id(current_user.userinfo.daycolor_id)
               end
            else
               if(!current_user.userinfo.daycolor_id.nil?)
                  usercolor = Colorscheme.find_by_id(current_user.userinfo.daycolor_id)
               else
                  usercolor = Colorscheme.find_by_id(current_user.userinfo.nightcolor_id)
               end
            end
            if(attribute == "Backgroundcolor")
               value = usercolor.backgroundcolor
            elsif(attribute == "Header")
               value = usercolor.headercolor
            elsif(attribute == "Subheader1")
               value = usercolor.subheader1color
            elsif(attribute == "Subheader2")
               value = usercolor.subheader2color
            elsif(attribute == "Subheader3")
               value = usercolor.subheader3color
            elsif(attribute == "Text")
               value = usercolor.textcolor
            elsif(attribute == "Navigation")
               value = usercolor.navigationcolor
            elsif(attribute == "Navigationlink")
               value = usercolor.navigationlinkcolor
            elsif(attribute == "Onlinestatus")
               value = usercolor.onlinestatuscolor
            elsif(attribute == "Profile")
               value = usercolor.profilecolor
            elsif(attribute == "Error")
               value = usercolor.errorcolor
            elsif(attribute == "Warning")
               value = usercolor.warningcolor
            elsif(attribute == "Notification")
               value = usercolor.notificationcolor
            elsif(attribute == "Success")
               value = usercolor.successcolor
            elsif(attribute == "Sessionc")
               value = usercolor.sessioncolor
            elsif(attribute == "Navigationhoverforc")
               value = usercolor.navigationhovercolor
            elsif(attribute == "Navigationhoverbackgc")
               value = usercolor.navigationhoverbackgcolor
            elsif(attribute == "Profilehovercolor")
               value = usercolor.profilehovercolor
            elsif(attribute == "Profilehoverbackgc")
               value = usercolor.profilehoverbackgcolor
            elsif(attribute == "Navlink")
               value = usercolor.navlinkcolor
            elsif(attribute == "Navlinkhovercolor")
               value = usercolor.navlinkhovercolor
            elsif(attribute == "Navlinkhoverbackgc")
               value = usercolor.navlinkhoverbackgcolor
            elsif(attribute == "Explanationborder")
               value = usercolor.explanationborder
            elsif(attribute == "Explanationbackgc")
               value = usercolor.explanationbackgcolor
            elsif(attribute == "Explanheadercolor")
               value = usercolor.explanheadercolor
            elsif(attribute == "Explantextcolor")
               value = usercolor.explantextcolor
            elsif(attribute == "Errorfieldcolor")
               value = usercolor.errorfieldcolor
            elsif(attribute == "Editbuttoncolor")
               value = usercolor.editbuttoncolor
            elsif(attribute == "Editbuttonbackgc")
               value = usercolor.editbuttonbackgcolor
            elsif(attribute == "Destroybuttoncolor")
               value = usercolor.destroybuttoncolor
            elsif(attribute == "Destroybuttonbackgc")
               value = usercolor.destroybuttonbackgcolor
            elsif(attribute == "Submitbuttoncolor")
               value = usercolor.submitbuttoncolor
            elsif(attribute == "Submitbuttonbackgc")
               value = usercolor.submitbuttonbackgcolor
            end
         else
            default = Colorscheme.find_by_id(1)
            if(attribute == "Backgroundcolor")
               value = default.backgroundcolor
            elsif(attribute == "Header")
               value = default.headercolor
            elsif(attribute == "Subheader1")
               value = default.subheader1color
            elsif(attribute == "Subheader2")
               value = default.subheader2color
            elsif(attribute == "Subheader3")
               value = default.subheader3color
            elsif(attribute == "Text")
               value = default.textcolor
            elsif(attribute == "Navigation")
               value = default.navigationcolor
            elsif(attribute == "Navigationlink")
               value = default.navigationlinkcolor
            elsif(attribute == "Onlinestatus")
               value = default.onlinestatuscolor
            elsif(attribute == "Profile")
               value = default.profilecolor
            elsif(attribute == "Error")
               value = default.errorcolor
            elsif(attribute == "Warning")
               value = default.warningcolor
            elsif(attribute == "Notification")
               value = default.notificationcolor
            elsif(attribute == "Success")
               value = default.successcolor
            elsif(attribute == "Navigationhoverforc")
               value = default.navigationhovercolor
            elsif(attribute == "Navigationhoverbackgc")
               value = default.navigationhoverbackgcolor
            elsif(attribute == "Profilehovercolor")
               value = default.profilehovercolor
            elsif(attribute == "Profilehoverbackgc")
               value = default.profilehoverbackgcolor
            elsif(attribute == "Navlink")
               value = default.navlinkcolor
            elsif(attribute == "Navlinkhovercolor")
               value = default.navlinkhovercolor
            elsif(attribute == "Navlinkhoverbackgc")
               value = default.navlinkhoverbackgcolor
            elsif(attribute == "Submitbuttoncolor")
               value = default.submitbuttoncolor
            elsif(attribute == "Submitbuttonbackgc")
               value = default.submitbuttonbackgcolor
            end
         end
         return value
      end

      def getHomepageMusic
         music = ""
         if(current_user)
            homepageSound = Pagesound.find_by_name("Homepage-Music")
            betaSound = Pagesound.find_by_name("Beta-Music")
            grandSound = Pagesound.find_by_name("Grandopening-Music")
            if(current_user.userinfo.browser == "ogg-browser")
               betaMode = Maintenancemode.find_by_id(2)
               grandMode = Maintenancemode.find_by_id(3)
               music = homepageSound.ogg_url
               if(betaMode.maintenance_on)
                  music = betaSound.ogg_url
               elsif(grandMode.maintenance_on)
                  music = grandSound.ogg_url
               end
            elsif(current_user.userinfo.browser == "mp3-browser")
               betaMode = Maintenancemode.find_by_id(2)
               grandMode = Maintenancemode.find_by_id(3)
               music = homepageSound.mp3_url
               if(betaMode.maintenance_on)
                  music = betaSound.mp3_url
               elsif(grandMode.maintenance_on)
                  music = grandSound.mp3_url
               end
            end
         else
            betaMode = Maintenancemode.find_by_id(2)
            grandMode = Maintenancemode.find_by_id(3)
            homepageSound = Pagesound.find_by_name("Homepage-Music")
            betaSound = Pagesound.find_by_name("Beta-Music")
            grandSound = Pagesound.find_by_name("Grandopening-Music")
            music = homepageSound.ogg_url
            if(betaMode.maintenance_on)
               music = betaSound.ogg_url
            elsif(grandMode.maintenance_on)
               music = grandSound.ogg_url
            end
         end
         return music
      end
end
