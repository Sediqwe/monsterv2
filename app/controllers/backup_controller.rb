class BackupController < ApplicationController
  
  def index
    @backup = Game.all.order(name: :ASC)
  end
  
  
end
