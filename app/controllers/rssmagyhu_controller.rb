class RssmagyhuController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  def index
      bumm = ""
      require 'nokogiri'
      require 'open-uri'
      url = 'https://magyaritasok.hu'
      doc = Nokogiri::HTML(URI.open(url))
  

      # Adatok kinyerése
      downloads = []
      doc.css('.content.flex.items-center.pt-6.text-white.font-light').each do |item|
        download = {}
        download[:title] = item.css('a.white-link.font-medium').text.strip
        download[:desc] = item.css('.text-mpGray-300').text.strip
        download[:size] = item.css('span')[0].text.strip
        download[:date] = item.css('span')[1].text.strip
        download[:author] = item.css('a.red-link').text.strip
        download[:link] = item.css('a.white-link.font-medium')
        
        downloads << download
      end

      # Eredmény kiíratása
      downloads.each do |download|
        data_without_linebreaks = download[:size].gsub("\n", "")
        # Szétválasztja az adatokat a | jel alapján
        separated_data = data_without_linebreaks.split("|").map(&:strip)
        # Az adatok kinyerése a szétválasztott tömbből
        size = separated_data[1].strip
        date = separated_data[2].strip
        author = separated_data[3].strip
        link_element = download[:link].at_css('a')
        link = link_element['href'] if link_element
        magyhurss = Magyhurss.where(name: download[:title], ido: date, meret: size )
                        if magyhurss.empty?
                          magyhurss = Magyhurss.create(link: link, name: download[:title], desc: download[:desc], ido: date, meret: size, uploader: author )
                        end        
      end
      adat = Magyhurss.where(okes: [false, nil]).first
        if adat
            adat.okes = true
            adat.save
            kata = strip_tags(adat.desc.to_s)
            render html: (adat.name + "||||Ł" + adat.uploader + "||||Ł" + adat.link + "||||Ł" + kata + "||||Ł" + adat.meret)
        
        else
        render html: ("")
    end
    
  end
  

end
