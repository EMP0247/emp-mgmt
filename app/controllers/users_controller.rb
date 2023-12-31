class UsersController < ApplicationController
    def index
        @users = User.all.page(params[:page]).per(params[:limit])
    end

    def valid_password?(password)
        return false if sso_enabled?
    
        super
    end

    def show
        @users = User.find(params[:id])
    end

    def new
        @users = User.new
    end

    def create
        redirect_to root_path
    end

    def edit
        @users = User.find(params[:id])
    end

    def update
        @users = User.find(params[:id])
        if @users.update(user_params)
            redirect_to users_url, notice: "Users is updated with New Role."
        else 
            render :edit, status: :unprocessable_entity
        end
    end

    def show
        @users = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:email,:password,:name,:role_ids => [])
    end
end