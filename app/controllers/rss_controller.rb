class RssController < ApplicationController
    include ActionView::Helpers::SanitizeHelper
    def index
        require 'rss'
        require 'open-uri'
        url = 'https://gep-monster.disqus.com/latest.rss'
        URI.open(url) do |rss|
           
                    feed = RSS::Parser.parse(rss)
                    feed.items.each_with_index do |item,index|
                        if item.link.exclude?("gep-monster.translate.goog")
                            gemorss = Gemorss.find_by(link: item.link)
                            
                            parsed_date = DateTime.parse(item.pubDate.to_s) + 5.hours 
                            if gemorss.nil?
                                gemorss = Gemorss.create(link: item.link, user: item.dc_creator.to_s, desc: item.description, idouj: parsed_date.strftime("%Y-%m-%d %H:%M") )
                            end
                        end
                        
                    end
                    end
                    
        adat = Gemorss.where(okes: [false, nil]).first
        if adat
            adat.okes = true
            adat.save
            kata = strip_tags(adat.desc.to_s)
            render html: (adat.user + "||||Ł" + adat.link + "||||Ł" + kata+ "||||Ł" + adat.idouj.to_s)
        
        else
        render html: ("")
    end
        
    end
end
