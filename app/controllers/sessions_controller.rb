class SessionsController < ApplicationController
    skip_before_action :authenticate

    def new
    end

    def create
        @user = User.find_by(username: params[:username])
        if @user.authenticate(params[:password])
            session[:current_user_id] = @user.id
            redirect_to @user
        else
          render :new
        end
    end

    def destroy
        reset_session
        redirect_to '/sessions/new'
    end
end
