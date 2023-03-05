module GamesHelper
    def number_game(game)
        num = Game.where('lower(name) LIKE ?',  game.downcase + '%').size
        p num
      end
    def Rebase
      
    end
end
