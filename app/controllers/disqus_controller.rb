class DisqusController < ApplicationController
    def index
        @gamemessage = Gamemessage.where(accept: nil)
        end
end
