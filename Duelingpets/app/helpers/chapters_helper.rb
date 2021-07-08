module ChaptersHelper

   private
      def getChapterParams(type)
         value = ""
         if(type == "Id")
            value = params[:id]
          elsif(type == "ChapterId")
            value = params[:chapter_id]
         elsif(type == "Book")
            value = params[:book_id]
         elsif(type == "Chapter")
            value = params.require(:chapter).permit(:title, :story, :voice1ogg, :remote_voice1ogg_url, :voice1ogg_cache,
            :voice1mp3, :remote_voice1mp3_url, :voice1mp3_cache, :voice2ogg, :remote_voice2ogg_url, :voice2ogg_cache,
            :voice2mp3, :remote_voice2mp3_url, :voice2mp3_cache, :voice3ogg, :remote_voice3ogg_url, :voice3ogg_cache,
            :voice3mp3, :remote_voice3mp3_url, :voice3mp3_cache, :bookcover, :remote_bookcover_url, :bookcover_cache,
            :storyscene1, :remote_storyscene1_url, :storyscene1_cache, :bookgroup_id)
         elsif(type == "Page")
            value = params[:page]
         else
            raise "Invalid type detected!"
         end
         return value
      end
      
      def economyTransaction(type, points, userid, currency)
         newTransaction = Economy.new(params[:economy])
         #Determines the type of attribute to return
         if(type != "Tax")
            newTransaction.econattr = "Content"
         else
            newTransaction.econattr = "Treasury"
         end
         newTransaction.content_type = "Chapter"
         newTransaction.econtype = type
         newTransaction.amount = points
         #Currency can be either Points, Emeralds or Skildons
         newTransaction.currency = currency
         if(type != "Tax")
            newTransaction.user_id = userid
         else
            newTransaction.dragonhoard_id = 1
         end
         newTransaction.created_on = currentTime
         @economytransaction = newTransaction
         @economytransaction.save
      end

      def updateBookworld(book)
         book.updated_on = currentTime
         @book = book
         @book.save
         bookworld = Bookworld.find_by_id(@book.bookworld_id)
         bookworld.updated_on = currentTime
         @bookworld = bookworld
         @bookworld.save
      end

      def editCommons(type)
         chapterFound = Chapter.find_by_id(getChapterParams("Id"))
         if(chapterFound)
            logged_in = current_user
            if(logged_in && ((logged_in.id == chapterFound.user_id) || logged_in.pouch.privilege == "Admin"))
               chapterFound.updated_on = currentTime
               chapterFound.reviewed = false

               #Determines the type of bookgroup the user belongs to
               allGroups = Bookgroup.order("created_on desc")
               allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
               @group = allowedGroups
               @chapter = chapterFound
               @book = Book.find_by_id(chapterFound.book.id)
               if(type == "update")
                  if((@chapter.bookcover.to_s != "" && @chapter.story.to_s == "") || (@chapter.story.to_s != "" && @chapter.bookcover.to_s == ""))
                     if(@chapter.update_attributes(getChapterParams("Chapter")))
                        updateBookworld(@book)
                        flash[:success] = "Chapter #{@chapter.title} was successfully updated."
                        redirect_to book_chapter_path(@chapter.book, @chapter)
                     else
                        render "edit"
                     end
                  else
                     flash[:error] = "An invalid selection was made!"
                     render "edit"
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
         end
      end

      def showCommons(type)
         chapterFound = Chapter.find_by_id(getChapterParams("Id"))
         if(chapterFound)
            removeTransactions
            if((current_user && ((chapterFound.user_id == current_user.id) || (current_user.pouch.privilege == "Admin"))) || (checkBookgroupStatus(chapterFound)))
               #visitTimer(type, blogFound)
               #cleanupOldVisits
               @chapter = chapterFound
               if(type == "destroy")
                  logged_in = current_user
                  if(logged_in && ((logged_in.id == chapterFound.user_id) || logged_in.pouch.privilege == "Admin"))
                     cleanup = Fieldcost.find_by_name("Chaptercleanup")
                     if(chapterFound.user.pouch.amount - cleanup.amount >= 0)
                        #Rebuilds the current chapter format
                        chapterNumber = @chapter.gchapter_id
                        bookFound = Book.find_by_id(@chapter.book_id)
                        allChapters = bookFound.chapters.all
                        fixChapters = allChapters.select{|chapter| chapter.gchapter_id > chapterNumber}
                        if(fixChapters.count > 0)
                           fixChapters.each do |chapter|
                              chapter.gchapter_id -= 1
                              @temp = chapter
                              @temp.save
                           end
                        end
                     
                        #Removes the content and decrements the owner's pouch
                        chapterFound.user.pouch.amount -= cleanup.amount
                        @pouch = chapterFound.user.pouch
                        @pouch.save
                        economyTransaction("Sink", cleanup.amount, chapterFound.user.id, "Points")
                        flash[:success] = "#{@chapter.title} was successfully removed."
                        @chapter.destroy
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to chapters_path
                        else
                           redirect_to bookworld_book_path(chapterFound.book.bookworld, chapterFound.book)
                        end
                     else
                        flash[:error] = "#{@chapter.user.vname}'s has insufficient points to remove the chapter!"
                        if(logged_in.pouch.privilege == "Admin")
                           redirect_to chapters_path
                        else
                           redirect_to bookworld_book_path(chapterFound.book.bookworld, chapterFound.book)
                        end
                     end
                  else
                     redirect_to root_path
                  end
               end
            else
               redirect_to root_path
            end
         else
            render "webcontrols/missingpage"
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
                  allChapters = Chapter.order("updated_on desc, created_on desc")
                  @chapters = Kaminari.paginate_array(allChapters).page(getChapterParams("Page")).per(10)
               else
                  redirect_to root_path
               end
            elsif(type == "new" || type == "create")
               allMode = Maintenancemode.find_by_id(1)
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(allMode.maintenance_on)
                     render "/start/maintenance"
                  else
                     render "/bookworlds/maintenance"
                  end
               else
                  logged_in = current_user
                  bookFound = Book.find_by_id(getChapterParams("Book"))
                  if(logged_in && bookFound)
                     if(logged_in.id == bookFound.user_id || (bookFound.collab_mode &&
                        checkBookgroupStatus(bookFound)))
                        newChapter = bookFound.chapters.new
                        if(type == "create")
                           newChapter = bookFound.chapters.new(getChapterParams("Chapter"))
                           newChapter.created_on = currentTime
                           newChapter.updated_on = currentTime
                           newChapter.user_id = logged_in.id
                           chapterNumber = bookFound.chapters.count + 1

                           #Determines if we should create a new generalchapter
                           chapterFound = Gchapter.find_by_id(chapterNumber)
                           if(!chapterFound)
                              newGeneralChapter = Gchapter.new(params[:gchapter])
                              newGeneralChapter.title = "Chapter-" + chapterNumber.to_s
                              newGeneralChapter.created_on = currentTime
                              newGeneralChapter.chapternum = chapterNumber
                              @generalchapter = newGeneralChapter
                              @generalchapter.save
                              chapterFound = newGeneralChapter
                           end
                           newChapter.gchapter_id = chapterFound.id
                        end

                        #Determines the type of bookgroup the user belongs to
                        allGroups = Bookgroup.order("created_on desc")
                        allowedGroups = allGroups.select{|bookgroup| bookgroup.id <= getWritingGroup(logged_in, "Id")}
                        @group = allowedGroups
                        @chapter = newChapter
                        @book = bookFound

                        if(type == "create")
                           if(@chapter.save)
                              chaptertag = Chaptertag.new(params[:chaptertag])
                              chaptertag.chapter_id = @chapter.id
                              chaptertag.tag1_id = 1
                              @chaptertag = chaptertag
                              @chaptertag.save
                              updateBookworld(@chapter.book)
                              url = "http://www.duelingpets.net/chapters/review"
                              ContentMailer.content_review(@chapter, "Chapter", url).deliver_now
                              flash[:success] = "#{@chapter.title} was successfully created."
                              redirect_to book_chapter_path(@book, @chapter)
                           else
                              render "new"
                           end
                        end
                     else
                        redirect_to root_path
                     end
                  else
                     redirect_to root_path
                  end
               end
            elsif(type == "edit" || type == "update")
               if(current_user && current_user.pouch.privilege == "Admin")
                  editCommons(type)
               else
                  allMode = Maintenancemode.find_by_id(1)
                  bookworldMode = Maintenancemode.find_by_id(12)
                  if(allMode.maintenance_on || bookworldMode.maintenance_on)
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  else
                     editCommons(type)
                  end
               end
            elsif(type == "show" || type == "destroy")
               allMode = Maintenancemode.find_by_id(1)
               bookworldMode = Maintenancemode.find_by_id(12)
               if(allMode.maintenance_on || bookworldMode.maintenance_on)
                  if(current_user && current_user.pouch.privilege == "Admin")
                     showCommons(type)
                  else
                     if(allMode.maintenance_on)
                        render "/start/maintenance"
                     else
                        render "/bookworlds/maintenance"
                     end
                  end
               else
                  showCommons(type)
               end
            elsif(type == "review")
               logged_in = current_user
               if(logged_in)
                  removeTransactions
                  allChapters = Chapter.order("reviewed_on desc, created_on desc")
                  if(logged_in.pouch.privilege == "Admin" || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                     chaptersToReview = allChapters.select{|chapter| !chapter.reviewed}
                     @chapters = Kaminari.paginate_array(chaptersToReview).page(getChapterParams("Page")).per(10)
                  else
                     redirect_to root_path
                  end
               else
                  redirect_to root_path
               end
            elsif(type == "approve" || type == "deny")
               logged_in = current_user
               if(logged_in)
                  chapterFound = Chapter.find_by_id(getChapterParams("ChapterId"))
                  if(chapterFound)
                     pouchFound = Pouch.find_by_user_id(logged_in.id)
                     if((logged_in.pouch.privilege == "Admin") || ((logged_in.pouch.privilege == "Keymaster") || (logged_in.pouch.privilege == "Reviewer")))
                        if(type == "approve")
                           chapterFound.reviewed = true
                           chapterFound.reviewed_on = currentTime
                           updateBookworld(chapterFound.book)
                           points = 0
                           if(!chapterFound.pointsreceived)
                              pointsForChapter = Fieldcost.find_by_name("Chapter")
                              pouch = Pouch.find_by_user_id(@chapter.user_id)
                              pouch.amount += pointsForChapter.amount
                              @pouch = pouch
                              @pouch.save
                              economyTransaction("Source", pointsForChapter.amount, @chapter.user.id, "Points")
                              points = pointsForChapter.amount
                              chapterFound.pointsreceived = true
                           end
                           @chapter = chapterFound
                           @chapter.save
                           ContentMailer.content_approved(@chapter, "Chapter", points).deliver_now
                           flash[:success] = "#{@chapter.user.vname}'s chapter #{@chapter.title} was approved."
                           redirect_to chapters_review_path
                        else
                           @chapter = chapterFound
                           ContentMailer.content_denied(@chapter, "Chapter").deliver_now
                           flash[:success] = "#{@chapter.user.vname}'s chapter #{@chapter.title} was denied."
                           redirect_to chapters_review_path
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
end
