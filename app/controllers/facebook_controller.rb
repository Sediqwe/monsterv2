class FacebookController < ApplicationController
  def index
      @facebook = Upload.order('id DESC').limit(200)   
  end
end
