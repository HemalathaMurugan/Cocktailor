class ApplicationController < ActionController::Base
<<<<<<< HEAD
    #before_action :authenticate
=======
before_action :authenticate
>>>>>>> new2

    def authenticate
        if(session[:current_user_id]==nil || User.find(session[:current_user_id])==nil)
            redirect_to '/sessions'
        end
    end
end
