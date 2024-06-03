class DisqusController < ApplicationController
    def index
        @gamemessage = Gamemessage.where(accept: nil)
        require 'date'

        egy_honapja = Date.today << 1  # Egy hónappal ezelőtti dátum

        @egyedi_beleptetesek = ActivityLog
        .where("note LIKE 'Beléptetve:%'")
        .where(created_at: egy_honapja..Date.today)
        .distinct
        .count
    end
end
