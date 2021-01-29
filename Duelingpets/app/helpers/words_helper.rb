module WordsHelper

   private
      def stylizedText(textString, categoryType)
         styleString = textString

         #Emphasizes the content for description fields
         if(categoryType == "Bold")
            styleString = textString.gsub(/\[[Bb][Oo][Ll][Dd]\]([\w\s.?!,$'"*:;-]+)\[\/[Bb][Oo][Ll][Dd]\]/){"<strong>"+$1+"</strong>"}
         elsif(categoryType == "Italic")
            styleString = textString.gsub(/\[[Ii][Tt][Aa][Ll][Ii][Cc]\]([\w\s.?!,$'"*:;-]+)\[\/[Ii][Tt][Aa][Ll][Ii][Cc]\]/){"<em>"+$1+"</em>"}
         elsif(categoryType == "Underline")
            #Remember to replace u tag with div tag
            styleString = textString.gsub(/\[[Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee]\]([\w\s.?!,$'"*:;-]+)\[\/[Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee]\]/){"<u>"+$1+"</u>"}
         elsif(categoryType == "All")
            styleString = textString.gsub(/\[[Bb][Oo][Ll][Dd]\]([\w\s.?!,$'"*:;-]+)\[\/[Bb][Oo][Ll][Dd]\]/){"<strong>"+$1+"</strong>"}
            styleString = styleString.gsub(/\[[Ii][Tt][Aa][Ll][Ii][Cc]\]([\w\s.?!,$'"*:;-]+)\[\/[Ii][Tt][Aa][Ll][Ii][Cc]\]/){"<em>"+$1+"</em>"}
            styleString = styleString.gsub(/\[[Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee]\]([\w\s.?!,$'"*:;-]+)\[\/[Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee]\]/){"<u>"+$1+"</u>"}
         end

         return styleString
      end

      def pageFormating(textString, categoryType)
         pageString = textString

         #Handles how the page is formated
         if(categoryType == "Pagebreak")
            pageString = textString.gsub(/\n/, '<br/>')
         elsif(categoryType == "Strike")
            pageString = textString.gsub(/\[[Ss][Tt][Rr][Ii][Kk][Ee]\]([\w\s.?!,$'"*:;-]+)\[\/[Ss][Tt][Rr][Ii][Kk][Ee]\]/){"<del>"+$1+"</del>"}
         elsif(categoryType == "Link")
            pageString = textString.gsub(/\[[Ll][Ii][Nn][Kk]\]([\w\s\/:.-]+)\[[Nn][Aa][Mm][Ee]\]([\w\s\/:.-]+)\[\/[Nn][Aa][Mm][Ee]\]\[\/[Ll][Ii][Nn][Kk]\]/){"<a href=#{$1}>"+$2+"</a>"}
         elsif(categoryType == "All")
            pageString = textString.gsub(/\n/, '<br/>')
            pageString = pageString.gsub(/\[[Ss][Tt][Rr][Ii][Kk][Ee]\]([\w\s.?!,$'"*:;-]+)\[\/[Ss][Tt][Rr][Ii][Kk][Ee]\]/){"<del>"+$1+"</del>"}
            pageString = pageString.gsub(/\[[Ll][Ii][Nn][Kk]\]([\w\s\/:.-]+)\[[Nn][Aa][Mm][Ee]\]([\w\s\/:.-]+)\[\/[Nn][Aa][Mm][Ee]\]\[\/[Ll][Ii][Nn][Kk]\]/){"<a href=#{$1}>"+$2+"</a>"}
         end

         return pageString
      end

      def profileText(textString, categoryType)
         profileString = textString

         #Displays attributes related to the users profile
         if(categoryType == "Profile")
            profileString = textString.gsub(/\[[Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]([\w\s\/:.-]+)\[\/[Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.miniavatar_url(:thumb))}
         elsif(categoryType == "Profilename")
            profileString = textString.gsub(/\[[Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]([\w\s\/:.-]+)\[\/[Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.miniavatar_url(:thumb)) + "#{$1}"}
         elsif(categoryType == "Largeprofile")
            profileString = textString.gsub(/\[[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]([\w\s\/:.-]+)\[\/[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.avatar_url(:thumb))}
         elsif(categoryType == "Largeprofilename")
            profileString = textString.gsub(/\[[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]([\w\s\/:.-]+)\[\/[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.avatar_url(:thumb)) + "#{$1}"}
         elsif(categoryType == "All")
            profileString = textString.gsub(/\[[Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]([\w\s\/:.-]+)\[\/[Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.miniavatar_url(:thumb))}
            profileString = profileString.gsub(/\[[Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]([\w\s\/:.-]+)\[\/[Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.miniavatar_url(:thumb)) + "#{$1}"}
            profileString = profileString.gsub(/\[[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]([\w\s\/:.-]+)\[\/[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.avatar_url(:thumb))}
            profileString = profileString.gsub(/\[[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]([\w\s\/:.-]+)\[\/[Ll][Aa][Rr][Gg][Ee][Pp][Rr][Oo][Ff][Ii][Ll][Ee][Nn][Aa][Mm][Ee]\]/){image_tag(User.find_by_vname($1).userinfo.avatar_url(:thumb)) + "#{$1}"}
         end

         return profileString
      end

      def codeSection(textString)
         #Useful for sharing c++, or other programming languages
         codeString = textString
         codeString = textString.gsub(/\[[Cc][Oo][Dd][Ee]\]([\w\s@*#%$&|!?,.;:'"{}\[\]^()=+*\/-]+)\[\/[Cc][Oo][Dd][Ee]\]/){"<code>"+$1+"</code>"}
         codeString = codeString.gsub(/\[[Gg][Rr][Ee][Aa][Tt][Ee][Rr]\]/){">"}
         codeString = codeString.gsub(/\[[Ll][Ee][Ss][Ss]\]/){"<"}
         codeString = codeString.gsub(/\*\*\*\*([\w\s@]+)\*\*\*\*/){"<#"+$1+">"}
         return codeString
      end

      def textFormater(formatType, textString, categoryType)
         formatedText = textString

         #Determines the correct format type
         if(formatType == "Stylized")
            formatedText = stylizedText(textString, categoryType)
         elsif(formatType == "Formatting")
            formatedText = pageFormating(textString, categoryType)
         elsif(formatType == "Profiletext")
            formatedText = profileText(textString, categoryType)
         elsif(formatType == "Code")
            formatedText = codeSection(textString)
         elsif(formatType == "Multi")
            formatedText = codeSection(textString)
            formatedText = stylizedText(formatedText, categoryType)
            formatedText = pageFormating(formatedText, categoryType)
            formatedText = profileText(formatedText, categoryType)
         end
         return formatedText
      end
end
