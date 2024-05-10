class ForumController < ApplicationController
  def index
    @unique_game_messages =  Gamemessage.latest_messages_per_game

    
  end
  def indexketto
    @game_messages = Gamemessage.where(game_id: params[:id]).order(created_at: :desc)
  end
end
