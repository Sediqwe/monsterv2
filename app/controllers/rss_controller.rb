class RssController < ApplicationController
    include ActionView::Helpers::SanitizeHelper
    def index
        require 'rss'
        require 'open-uri'
        url = 'https://gep-monster.disqus.com/latest.rss'
        URI.open(url) do |rss|
           
                    feed = RSS::Parser.parse(rss)
                    feed.items.each_with_index do |item,index|
                        itemlink = item.link.gsub("gep-monster.translate.goog/","gep.monster")
                        itemlink = itemlink.gsub("?_x_tr_sl=hu&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc","")
                        gemorss = Gemorss.find_by(link: itemlink)
                        if gemorss.nil?
                            gemorss = Gemorss.create(link: itemlink, user: item.dc_creator.to_s, desc: item.description, ido: item.pubDate)
                        end
                        
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
