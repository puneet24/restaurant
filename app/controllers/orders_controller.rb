class OrdersController < ApplicationController
    before_action :set_order, only: [:update]
    skip_before_action :authenticate_request, only: [:update]
    before_action :admin_authenticate_request, only: [:update]

    def index
        render json: @current_user.orders, status: :ok
    end

    def create
        @order = Order.create({user_id: @current_user.id})
        @order_items = []
        order_params["items"].each do |order_item|
            order_item = OrderItem.create({ order_id: @order.id, item_id: order_item["id"] })
            @order_items << order_item
        end
        @order.reload
        @order.process_order
        OrderNotificationJob.set(wait: 2.minutes).perform_later(@order.id)
        render json: {order: @order, items: @order_items }, status: :ok
    end

    def update
        @order.update!(update_order_params) if @order
        render json: @order, status: :ok
    end

    private
        def order_params
            params.permit!
        end

        def update_order_params
            params.permit(:status)
        end

        def set_order
            @order = Order.find(params[:id])
        end
end