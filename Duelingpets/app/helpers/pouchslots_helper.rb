module PouchslotsHelper

   private
      def getPouchslotParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
         elsif(type == "Pouchslot")
            value = params.require(:pouchslot).permit(:pouchtype1_id, :pouchtype2_id, :pouchtype3_id, :pouchtype4_id,
            :pouchtype5_id, :pouchtype6_id, :pouchtype7_id, :pouchtype8_id, :pouchtype9_id, :pouchtype10_id,
            :pouchtype11_id, :pouchtype12_id, :pouchtype13_id, :pouchtype14_id, :pouchtype15_id, :pouchtype16_id,
            :pouchtype17_id, :pouchtype18_id, :pouchtype19_id, :pouchtype20_id, :pouchtype21_id, :pouchtype22_id,
            :pouchtype23_id, :pouchtype24_id, :pouchtype25_id, :pouchtype26_id, :pouchtype27_id, :pouchtype28_id,
            :pouchtype29_id, :pouchtype30_id, :pouchtype31_id, :pouchtype32_id, :pouchtype33_id, :pouchtype34_id,
            :pouchtype35_id, :pouchtype36_id, :pouchtype37_id, :pouchtype38_id, :pouchtype39_id, :pouchtype40_id,
            :pouchtype41_id, :pouchtype42_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
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
                  allPouchslots = Pouch.order("id desc")
                  @pouchslots = Kaminari.paginate_array(allPouchslots).page(getPouchslotParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "edit" || type == "update")
               pouchslotFound = Pouchslot.find_by_id(getPouchslotParams("Id"))
               if(pouchslotFound)
                  logged_in = current_user
                  if(logged_in && logged_in.pouch.privilege == "Admin")
                     allPouchtypes = Pouchtype.order("name desc")
                     @group = allPouchtypes
                     @pouchslot = pouchslotFound
                     if(type == "update")
                        if(@pouchslot.update(getPouchslotParams("Pouchslot")))
                           flash[:success] = "#{@pouchslot.pouch.user.vname}'s pouchslot was successfully updated."
                           redirect_to pouchslots_path
                        else
                           render "edit"
                        end
                     end
                  else
                     redirect_to root_path
                  end
               else
                  render "webcontrols/missingpage"
               end
            else
               redirect_to root_path
            end
         end
      end
end
