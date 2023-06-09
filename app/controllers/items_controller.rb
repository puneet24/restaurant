class ItemsController < ApplicationController
    skip_before_action :authenticate_request, only: [:create, :update, :destroy]
    before_action :admin_authenticate_request, only: [:create, :update, :destroy]
    before_action :set_item, only: [:update, :destroy]

    def index
        @items = Item.all
        render json: @items, status: :ok
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            render json: @item, status: :ok
        else
            render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @item.update!(item_params)
        render json: @item, status: :ok
    end

    def destroy
        @item.destroy if @item
        render json: @item, status: :ok
    end

    private
        def item_params
            params.permit(:name, :description, :tax_rate, :price)
        end

        def set_item
            @item = Item.find(params[:id])
        end

end
