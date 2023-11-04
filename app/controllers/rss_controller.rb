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
                            raw_date = "Wed, 01 Nov 2023 15:57:04 -0000"
                            parsed_date = Time.parse(item.pubDate)
                            formatted_date = parsed_date.strftime("%Y.%m.%d %H:%M")
                            if gemorss.nil?
                                gemorss = Gemorss.create(link: item.link, user: item.dc_creator.to_s, desc: item.description, ido: formatted_date)
                            end
                        end
                        
                    end
                    end
                    
        adat = Gemorss.where(okes: [false, nil]).first
        if adat
            adat.okes = true
            adat.save
            kata = strip_tags(adat.desc.to_s)
            render html: (adat.user + "||||Ł" + adat.link + "||||Ł" + kata+ "||||Ł" + adat.ido)
        
        else
        render html: ("")
    end
        
    end
end
