class SupportController < ApplicationController
  def index
    @supporters = Supporter.all.order(id: :DESC)
    #@users = User.where.not(translater_id: nil)
    @users = User.where.not(translater_id: nil).joins(:supportlists).distinct

  end
end
