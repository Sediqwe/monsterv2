class SupportController < ApplicationController
  def index
    @supporters = Supporter.all
  end
end
