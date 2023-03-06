module ApplicationHelper
    def icon(icon, options = {})
        file = File.read("node_modules/bootstrap-icons/icons/#{icon}.svg")
        doc = Nokogiri::HTML::DocumentFragment.parse file
        svg = doc.at_css 'svg'
        if options[:class].present?
        svg['class'] += " " + options[:class]
        end
        doc.to_html.html_safe
    end
    @meta_title = "Gépi fordítások"
    def statisztika(game,upload_id)
        datum = Download.find(upload_id).created_at
        re = Download.where(game_id: game).where("created_at < ?", datum).size + 1
        #SalesReport.where(date: SalesReport.select('MAX(date)'))
    end
end
