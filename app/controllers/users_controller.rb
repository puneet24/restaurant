class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create, :index, :update]
    before_action :set_user, only: [:show, :destroy, :update]

    def index
        @users = User.all
        render json: @users, status: :ok
    end

    def show
        render json: @user, status: :ok
    end

    def create
        @user = User.new(user_params)
        if(@user.save)
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages }, 
            status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: @user, status: :ok
        else
            render json: {errors: @user.errors.full_messages}
        end
    end

    def destroy
        @user.destroy
    end

    private
        def user_params
            params.permit(:name, :username, :email, :password, :id, :role)
        end

        def set_user
            @user = User.find(params[:id])
        end
end
