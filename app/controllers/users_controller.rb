class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]
    before_action :set_format_request, only: [:show]

    # REGISTER
    def create
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else
            render json: {error: "Invalid username or password"}
        end
    end

    def show
        @users = User.all
        render json: @users
    end

    # LOGGING IN
    def login
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id, exp: Time.now.to_i + 1.minutes})
            render json: {user: @user, token: token}
        else
            render json: {error: "Invalid username or password"}
        end
    end


    def auto_login
        render json: @user
    end

    private

    def user_params
        params.permit(:username, :password, :age)
    end
end
