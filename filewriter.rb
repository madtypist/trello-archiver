def createspreadsheet(board, filenamestub="productbacklogbackup")
  lists = board.lists
  filename = "archive/#{DateTime.now.strftime "%Y%m%dT%H%M"}_#{filenamestub}.xslx"
  SimpleXlsx::Serializer.new(filename) do |doc|
    lists.each do |list|
      puts list.name
      cards = list.cards
      doc.add_sheet(list.name) do |sheet|
        sheet.add_row(%w{Name Description Labels})
        cards.each do |card|
          puts "Title: #{card.name} Desc: #{card.description} List: #{card.list.name} Labels:#{card.labels.length}"
          if card.labels.length==0 then labellist = "none" else labellist = "" end
          card.labels.each do |label|
            labellist += " " + label.name
          end
          sheet.add_row([card.name, card.description, labellist])
        end
      end
    end
  end
end