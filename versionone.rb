def versiononeformat(board, filenamestub="productbacklogbackup", includecomments=true)
  lists = board.lists
  filename = "transform/#{DateTime.now.strftime "%Y%m%dT%H%M"}_#{filenamestub}.xslx"
  SimpleXlsx::Serializer.new(filename) do |doc|
    doc.add_sheet("Backlog Items") do |sheet|
      sheet.add_row(%w{AssetType Name Scope Description Estimate Priority})
      lists.each do |list|
        puts list.name
        cards = list.cards
        if (list.name != "Done") && (list.name != "Ready for Final QA")
          regex = /\[BUG\]/
          estimate_regex = /\((\w*)\)/
          cards.each do |card|
            puts card.name.match regex
            assettype = (card.name.match regex) ? "Defect" : "Story"
            estimate = (card.name =~ estimate_regex) ? $1 : ""
            sheet.add_row([assettype, card.name, "Engineering", card.description, estimate, ""])
          end
        end
      end
    end
  end
end

def rallyformat(board, filenamestub="productbacklogbackup", includecomments=true)
  lists = board.lists
  filename = "transform/#{DateTime.now.strftime "%Y%m%dT%H%M"}_#{filenamestub}.xslx"
  SimpleXlsx::Serializer.new(filename) do |doc|
    doc.add_sheet("Backlog Items") do |sheet|
      sheet.add_row(%w{Display Ready Name Description Notes Owner Schedule State Estimate Blocked})
      lists.each do |list|
        puts list.name
        cards = list.cards
        if (list.name != "Done") && (list.name != "Ready for Final QA")
          regex = /\[BUG\]/
          estimate_regex = /\((\w*)\)/
          cards.each do |card|
            puts card.name

            if includecomments
              actions = card.actions
              commentslist = ""
              actions.each do |action|
                if action.type=="commentCard"
                  commentslist += "#{Member.find(action.member_creator_id).full_name} says: #{action.data['text']} \n\n"
                end
              end
            end
            assettype = (card.name.match regex) ? "Defect" : "Story"
            color = ""
            estimate = (card.name =~ estimate_regex) ? $1 : ""
            sheet.add_row([color, "FALSE", card.name, card.description, commentslist, "mad_typist@yahoo.com", "", "", estimate, "FALSE"])
          end
        end
      end
    end
  end
end
