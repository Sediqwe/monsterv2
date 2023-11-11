class ErrorsController < ApplicationController
    def hiba404
        if !request.url.include? "active_storage"
            if current_user
                errorka = Errorvan.new(page: request.url, desc: current_user.name)
                
            else
                errorka = Errorvan.new(page: request.url)    
            end
            errorka.save
        end        
    end
end