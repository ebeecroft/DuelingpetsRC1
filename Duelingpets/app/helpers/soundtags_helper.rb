module SoundtagsHelper

   private
      def getSoundtagParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "SoundtagId")
            value = params[:soundtag_id]
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end

      def getTagname(tagid)
         tag = Tag.find_by_id(tagid)
         return tag.name
      end
      
      def tagCommons(type)
         logged_in = current_user
         soundtagFound = Soundtag.find_by_id(getSoundtagParams("SoundtagId"))
         if(soundtagFound && logged_in)
            if(type == "addtag")
               tagFound = Tag.find_by_name(params[:soundtag][:name])
               slotFound = params[:soundtag][:tagslot]
               if(tagFound && !slotFound.nil? && logged_in.id == soundtagFound.sound.user_id)
                  errorFlag = false
                  #Determines if the tag is already in the soundtag list
                  tagset1 = (((soundtagFound.tag1_id != tagFound.id && soundtagFound.tag2_id != tagFound.id) && (soundtagFound.tag3_id != tagFound.id && soundtagFound.tag4_id != tagFound.id)) && ((soundtagFound.tag5_id != tagFound.id && soundtagFound.tag6_id != tagFound.id) && (soundtagFound.tag7_id != tagFound.id && soundtagFound.tag8_id != tagFound.id)))
                  tagset2 = (((soundtagFound.tag9_id != tagFound.id && soundtagFound.tag10_id != tagFound.id) && (soundtagFound.tag11_id != tagFound.id && soundtagFound.tag12_id != tagFound.id)) && ((soundtagFound.tag13_id != tagFound.id && soundtagFound.tag14_id != tagFound.id) && (soundtagFound.tag15_id != tagFound.id && soundtagFound.tag16_id != tagFound.id)))
                  tagset3 = ((soundtagFound.tag17_id != tagFound.id && soundtagFound.tag18_id != tagFound.id) && (soundtagFound.tag19_id != tagFound.id && soundtagFound.tag20_id != tagFound.id))
                  
                  #Checks if the tag is found
                  if(tagset1 && tagset2 && tagset3)
                     if(slotFound.to_i == 1)
                        soundtagFound.tag1_id = tagFound.id
                     elsif(slotFound.to_i == 2)
                        soundtagFound.tag2_id = tagFound.id
                     elsif(slotFound.to_i == 3)
                        soundtagFound.tag3_id = tagFound.id
                     elsif(slotFound.to_i == 4)
                        soundtagFound.tag4_id = tagFound.id
                     elsif(slotFound.to_i == 5)
                        soundtagFound.tag5_id = tagFound.id
                     elsif(slotFound.to_i == 6)
                        soundtagFound.tag6_id = tagFound.id
                     elsif(slotFound.to_i == 7)
                        soundtagFound.tag7_id = tagFound.id
                     elsif(slotFound.to_i == 8)
                        soundtagFound.tag8_id = tagFound.id
                     elsif(slotFound.to_i == 9)
                        soundtagFound.tag9_id = tagFound.id
                     elsif(slotFound.to_i == 10)
                        soundtagFound.tag10_id = tagFound.id
                     elsif(slotFound.to_i == 11)
                        soundtagFound.tag11_id = tagFound.id
                     elsif(slotFound.to_i == 12)
                        soundtagFound.tag12_id = tagFound.id
                     elsif(slotFound.to_i == 13)
                        soundtagFound.tag13_id = tagFound.id
                     elsif(slotFound.to_i == 14)
                        soundtagFound.tag14_id = tagFound.id
                     elsif(slotFound.to_i == 15)
                        soundtagFound.tag15_id = tagFound.id
                     elsif(slotFound.to_i == 16)
                        soundtagFound.tag16_id = tagFound.id
                     elsif(slotFound.to_i == 17)
                        soundtagFound.tag17_id = tagFound.id
                     elsif(slotFound.to_i == 18)
                        soundtagFound.tag18_id = tagFound.id
                     elsif(slotFound.to_i == 19)
                        soundtagFound.tag19_id = tagFound.id
                     elsif(slotFound.to_i == 20)
                        soundtagFound.tag20_id = tagFound.id
                     else
                        errorFlag = true
                     end
                     if(!errorFlag)
                        @soundtag = soundtagFound
                        @soundtag.save
                        flash[:success] = "Tag #{tagFound.name} was added to the list!"
                        redirect_to subsheet_sound_path(@soundtag.sound.subsheet, @soundtag.sound)
                     else
                        flash[:error] = "Invalid slot detected!"
                        redirect_to root_path
                     end
                  else
                     flash[:error] = "Tag #{tagFound.name} already exists in this list!"
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "removetag")
               errorFlag = false
               tagFound = Tag.find_by_id(params[:tagid])
               if(tagFound)
                  if(logged_in.pouch.privilege == "Admin" || logged_in.id == soundtagFound.sound.user_id)
                     tag = tagFound.id
                     if(soundtagFound.tag1_id == tag)
                        soundtagFound.tag1_id = nil
                     elsif(soundtagFound.tag2_id == tag)
                        soundtagFound.tag2_id = nil
                     elsif(soundtagFound.tag3_id == tag)
                        soundtagFound.tag3_id = nil
                     elsif(soundtagFound.tag4_id == tag)
                        soundtagFound.tag4_id = nil
                     elsif(soundtagFound.tag5_id == tag)
                        soundtagFound.tag5_id = nil
                     elsif(soundtagFound.tag6_id == tag)
                        soundtagFound.tag6_id = nil
                     elsif(soundtagFound.tag7_id == tag)
                        soundtagFound.tag7_id = nil
                     elsif(soundtagFound.tag8_id == tag)
                        soundtagFound.tag8_id = nil
                     elsif(soundtagFound.tag9_id == tag)
                        soundtagFound.tag9_id = nil
                     elsif(soundtagFound.tag10_id == tag)
                        soundtagFound.tag10_id = nil
                     elsif(soundtagFound.tag11_id == tag)
                        soundtagFound.tag11_id = nil
                     elsif(soundtagFound.tag12_id == tag)
                        soundtagFound.tag12_id = nil
                     elsif(soundtagFound.tag13_id == tag)
                        soundtagFound.tag13_id = nil
                     elsif(soundtagFound.tag14_id == tag)
                        soundtagFound.tag14_id = nil
                     elsif(soundtagFound.tag15_id == tag)
                        soundtagFound.tag15_id = nil
                     elsif(soundtagFound.tag16_id == tag)
                        soundtagFound.tag16_id = nil
                     elsif(soundtagFound.tag17_id == tag)
                        soundtagFound.tag17_id = nil
                     elsif(soundtagFound.tag18_id == tag)
                        soundtagFound.tag18_id = nil
                     elsif(soundtagFound.tag19_id == tag)
                        soundtagFound.tag19_id = nil
                     elsif(soundtagFound.tag20_id == tag)
                        soundtagFound.tag20_id = nil
                     else
                        #This case should never happen!
                        errorFlag = true
                     end
                     if(!errorFlag)
                        if(soundtagFound.tag1_id.nil? && soundtagFound.tag2_id.nil? && soundtagFound.tag3_id.nil? && soundtagFound.tag4_id.nil? && soundtagFound.tag5_id.nil? && soundtagFound.tag6_id.nil? && soundtagFound.tag7_id.nil? && soundtagFound.tag8_id.nil? && soundtagFound.tag9_id.nil? && soundtagFound.tag10_id.nil? && soundtagFound.tag11_id.nil? && soundtagFound.tag12_id.nil? && soundtagFound.tag13_id.nil? && soundtagFound.tag14_id.nil? && soundtagFound.tag15_id.nil? && soundtagFound.tag16_id.nil? && soundtagFound.tag17_id.nil? && soundtagFound.tag18_id.nil? && soundtagFound.tag19_id.nil? && soundtagFound.tag20_id.nil?)
                           soundtagFound.tag1_id = 1
                        end
                        @soundtag = soundtagFound
                        @soundtag.save
                        flash[:success] = "Tag #{getTagname(tag)} was successfully removed!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to soundtags_path
                        else
                           redirect_to subsheet_sound_path(@soundtag.sound.subsheet, @soundtag.sound)
                        end
                     else
                        flash[:error] = "This tag does not exist!"
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               else
                  flash[:error] = "Tagid is empty!"
                  redirect_to root_path
               end
            end
         else
            redirect_to root_path
         end
      end

      def mode(type)
         if(timeExpired)
            logout_user
            redirect_to root_path
         else
            logoutExpiredUsers
            if(type == "index")
               logged_in = current_user
               if(logged_in && logged_in.pouch.privilege == "Admin")
                  removeTransactions
                  allSoundtags = Soundtag.all
                  @soundtags = Kaminari.paginate_array(allSoundtags).page(getSoundtagParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "addtag" || type == "removetag")
               if(current_user && current_user.pouch.privilege == "Admin")
                  tagCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  userMode = Maintenancemode.find_by_id(6)
                  if(allMode.maintenance_on || userMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/users/maintenance"
                     end
                  else
                     tagCommons(type)
                  end
               end
            end
         end
      end
end
