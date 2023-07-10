class FacebookController < ApplicationController
  def index
      @facebook = Upload.order('id DESC').limit(20)
    
   
  end
end
