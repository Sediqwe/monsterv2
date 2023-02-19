class MagyhuController < ApplicationController
  def index
  end

  def beolvas
    require 'nokogiri'
    @bumm = ""
    @doc = Nokogiri::HTML(open('https://magyaritasok.hu/games/search?search=0&page=' + params[:oldal]))
    #<p class="text-mpGray-100 xl:whitespace-nowrap break-words"><a href="https://magyaritasok.hu/games/3d-formula-racing" class="white-link">3D Formula Racing
 
    # Search for nodes by css
    @doc.search('a').each do |link|
      if link.text.strip.length > 0
        @bumm += link.content.to_s.strip + "<BR>"
      end
    end
    tags = @doc.xpath("//a")
    tags.each do |tag|
      if tag[:href].include? "/games/" 
        if tag[:href].exclude? "search?"
          game = Magyhu.new
          game.name = tag.text
          game.link = tag[:href]
          game.save
          puts "#{tag[:href]}\t#{tag.text}"
        end
      end
    end
  end
end
