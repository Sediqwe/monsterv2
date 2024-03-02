class FacebookController < ApplicationController
  def index
    game = Upload.order('id DESC').limit(1).first
    adatok = Uploadtranslater.where(upload_id: game)
  
    facebook_ment = adatok.map { |dorka| dorka.translater.translater_name }.join(", ")
  
    fordito_program = if game.mauto
                       "Auto fordító"
                     elsif game.game_files.filename.to_s.downcase.include?("deepl")
                       "Deepl"
                     elsif game.game_files.filename.to_s.downcase.include?("google")
                       "Google"
                     else
                       ""
                     end
  
    tamogatas = adatok.map { |dorka| view_context.link_to(dorka.translater.translater_name, "https://gep.monster/translaters/#{dorka.translater.slug}") }.join(", ")

  
    komment_letoltes = view_context.link_to("https://gep.monster/games/#{game.game.slug}", "https://gep.monster/games/#{game.game.slug}")
  
    facebook_ment = "Nincs megadva fordító" if facebook_ment.blank?
    fordito_program = "Nincs megadva fordító program" if fordito_program.blank?
    tamogatas = "Nincs megadva fordítás támogatás" if tamogatas.blank?
  
    render html: "<div id=\"tartalom\"><b>#{game.name.upcase}</b><br>
                  <b>Verzió:</b> #{game.version}<br>
                  <b>Leírás:</b> #{game.description}<br>
                  <b>Készítő:</b> #{facebook_ment}<br>
                  <b>Fordító program:</b> #{fordito_program}<br>
                  <b>Támogatás:</b> #{tamogatas}<br>
                  <b>Hozzászólás / Letöltés:</b> #{komment_letoltes}<br>
                  <h3><b>A Facebook oldalon a hozzászólás le van tiltva, ha szeretnél ehhez a játékhoz hozzászólni vagy kérdezni, azt a linkre kattintva megteheted.</b></h3>".html_safe
                  
  end
end
