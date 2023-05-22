class RssController < ApplicationController
    include ActionView::Helpers::SanitizeHelper
    def index
        require 'rss'
        require 'open-uri'
        url = 'https://gep-monster.disqus.com/latest.rss'
        URI.open(url) do |rss|
           
                     feed = RSS::Parser.parse(rss)
                    
    
                     feed.items.each_with_index do |item,index|
                        gemo = Gemorss.find_or_create_by(link: item.link, user: item.dc_creator.to_s, desc: item.description, ido: item.pubDate )
                        gemo.save
                        
                     end
                    end
                    
        adat = Gemorss.where(okes: [false, nil]).first
        if adat
            adat.okes = true
            adat.save
            kata = strip_tags(adat.desc.to_s)
            render html: (adat.user + "||||Ł" + adat.link + "||||Ł" + kata)
        
        else
        render html: ("")
    end
        
    end
end
