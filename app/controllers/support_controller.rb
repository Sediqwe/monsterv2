class SupportController < ApplicationController
  def index
    @supporters = Supporter.all.order(id: :DESC)
  end
end
