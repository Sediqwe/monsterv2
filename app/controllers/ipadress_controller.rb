class IpadressController < ApplicationController
  def index
    @ipad = Download.all.group(:ip_address).order('count_id DESC').limit(10).count('id')      
  end
end
