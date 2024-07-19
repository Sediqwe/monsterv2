xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'QC RSS Feed'
    xml.description 'Legújabb QC dumák'
    
    @games.each do |game|
      xml.item do
        xml.user game.user
        xml.desc game.desc
        xml.pubDate game.idouj3.strftime("%Y-%m-%d %H:%M")
        xml.link game.link 
        
        
      end
    end
  end
end