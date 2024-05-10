module ForumHelper
    def user_where_last(game_id)
        Gamemessage.where(game_id: game_id).order(created_at: :DESC).first
    end
end
