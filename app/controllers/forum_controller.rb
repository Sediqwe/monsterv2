class ForumController < ApplicationController
  def index
    @unique_game_messages = Gamemessage.select("DISTINCT ON (game_id) game_id").order(game_id: :asc, created_at: :desc)

    
  end
  def indexketto
    @game_messages = Gamemessage.where(game_id: params[:id]).order(created_at: :desc)
  end
end
