xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.rss version: '2.0',
        'xmlns:content' => 'http://purl.org/rss/1.0/modules/content/',
        'xmlns:wfw' => 'http://wellformedweb.org/CommentAPI/',
        'xmlns:dc' => 'http://purl.org/dc/elements/1.1/',
        'xmlns:atom' => 'http://www.w3.org/2005/Atom',
        'xmlns:sy' => 'http://purl.org/rss/1.0/modules/syndication/',
        'xmlns:slash' => 'http://purl.org/rss/1.0/modules/slash/',
        'xmlns:media' => 'http://search.yahoo.com/mrss/' do

  xml.channel do
    xml.title 'QC RSS Feed'
    xml.link 'https://gep.monster'
    xml.description 'Legújabb QC dumák'
    xml.lastBuildDate Time.now.strftime("%a, %d %b %Y %H:%M:%S %z")
    xml.language 'hu'
    xml.sy :updatePeriod, 'hourly'
    xml.sy :updateFrequency, 1
    xml.generator 'Rails RSS Feed Generator'

    @games.each do |game|
      xml.item do
        xml.title "Új üzenet"
        xml.link game.link
        xml.pubDate game.idouj3.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.dc :creator, game.user
        xml.description do
          xml.cdata! game.desc
        end
        
      end
    end
  end
end
