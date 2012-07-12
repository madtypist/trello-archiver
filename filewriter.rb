def createspreadsheet(board, filenamestub="productbacklogbackup", includecomments=true)
  lists = board.lists
  filename = "archive/#{DateTime.now.strftime "%Y%m%dT%H%M"}_#{filenamestub}.xslx"
  SimpleXlsx::Serializer.new(filename) do |doc|
    lists.each do |list|
      puts list.name
      cards = list.cards
      doc.add_sheet(list.name) do |sheet|
        sheet.add_row(%w{Name Description Labels Comments})
        cards.each do |card|
          puts "Title: #{card.name} Desc: #{card.description} List: #{card.list.name} Labels:#{card.labels.length}"
          
          if card.labels.length==0 then labellist = "none" else labellist = "" end
          card.labels.each do |label|
            labellist += " " + label.name
          end

          if includecomments
            actions = card.actions
            commentslist = ""
            actions.each do |action|
              if action.type=="commentCard"
                commentslist += "#{Member.find(action.member_creator_id).full_name} says: #{action.data['text']} \n\n"
              end
            end
          end
          
          sheet.add_row([card.name, card.description, labellist, commentslist])
        end
      end
    end
  end
end
