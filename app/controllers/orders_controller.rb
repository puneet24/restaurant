class OrdersController < ApplicationController
    before_action :set_order, only: [:update]
    skip_before_action :authenticate_request, only: [:update]
    before_action :admin_authenticate_request, only: [:update]

    def index
        render json: @current_user.orders, status: :ok
    end

    def create
        @order = Order.create_order(@current_user.id, order_params)
        OrderNotificationJob.set(wait: 2.minutes).perform_later(@order.id)
        render json: {order: @order, items: @order.order_items }, status: :ok
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
