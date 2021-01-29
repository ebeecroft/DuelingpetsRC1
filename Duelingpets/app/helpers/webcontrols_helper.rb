module WebcontrolsHelper

   private
      def webcontrol_params
         # Never trust parameters from the scary internet, only allow the white list through.
         params.require(:webcontrol).permit(:banner, :remote_banner_url, :banner_cache, :mascot, 
         :remote_mascot_url, :mascot_cache, :favicon, :remote_favicon_url, :favicon_cache,
         :criticalogg, :remote_criticalogg_url, :criticalogg_cache, :criticalmp3, 
         :remote_criticalmp3_url, :criticalmp3_cache, :betaogg, :remote_betaogg_url,
         :betaogg_cache, :betamp3, :remote_betamp3_url, :betamp3_cache, :grandogg,
         :remote_grandogg_url, :grandogg_cache, :grandmp3, :remote_grandmp3_url,
         :grandmp3_cache, :ogg, :remote_ogg_url, :ogg_cache, :mp3, :remote_mp3_url, :mp3_cache,
         :creationogg, :remote_creationogg_url, :creationogg_cache, :creationmp3,
         :remote_creationmp3_url, :creationmp3_cache, :missingpageogg, :remote_missingpageogg_url,
         :missingpageogg_cache, :missingpagemp3, :remote_missingpagemp3_url, :missingpagemp3_cache,
         :maintenanceogg, :remote_maintenanceogg_url, :maintenanceogg_cache, :maintenancemp3,
         :remote_maintenancemp3_url, :maintenancemp3_cache, :daycolor_id, :nightcolor_id)
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(current_user && current_user.pouch.privilege == "Admin")
               if(type == "index")
                  removeTransactions
                  allControls = Webcontrol.order("created_on desc")
                  @webcontrols = Kaminari.paginate_array(allControls).page(params[:page]).per(10)
               elsif(type == "edit" || type == "update")
                  #Updates the Website's parameters such as the banner and favicon
                  controlFound = Webcontrol.find_by_id(params[:id])
                  if(controlFound)
                     @webcontrol = controlFound
                     if(type == "update")
                        if(@webcontrol.update(webcontrol_params))
                           flash[:success] = "The webcontrol was successfully updated."
                           redirect_to webcontrols_path
                        else
                           render "edit"
                        end
                     end
                  else
                     render "webcontrols/missingpage"
                  end
               elsif(type == "missingpage")

               end
            else
               redirect_to root_path
            end
         end
      end
end
