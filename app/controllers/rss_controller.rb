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
                            
                            rfc822_date = item.pubDate.to_s
                            parsed_parts = rfc822_date.match(/(\w{3}), (\d{2}) (\w{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2}) (.+)/)
                            
                            if parsed_parts
                              day, day_of_month, month, year, hour, minute, second, utc_offset = parsed_parts.captures
                              month_number = Date::ABBR_MONTHNAMES.index(month)
                            
                              parsed_date = Time.new(year.to_i, month_number, day_of_month.to_i, hour.to_i, minute.to_i, second.to_i, utc_offset)
                              
                            else
                              puts "Nem sikerült feldolgozni a dátumot."
                            end

                            new_time = Time.new(year, parsed_date.month, parsed_date.day, parsed_date.hour, parsed_date.min)
                            formatted_time = new_time.strftime("%Y.%m.%d %H:%M")
                            if gemorss.nil?
                                gemorss = Gemorss.create(link: item.link, user: item.dc_creator.to_s, desc: item.description, idouj: formatted_time)
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
