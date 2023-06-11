class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items

    enum :status, [ :in_progress, :completed, :cancelled ]

    def Order.create_order(user_id, order_params)
        @order = Order.create({ user_id: user_id })
        order_params["items"].each do |order_item|
            OrderItem.create({ order_id: @order.id, item_id: order_item["id"] })
        end
        @order.reload
        @order.process_order
        @order
    end

    def process_order
        self.order_items.each {|order_item| order_item.process_order_item(self) }
        self.total_price = self.order_items.reduce(0) do |accumulator, element|
            accumulator + element.final_price
        end
        self.total_price = self.total_price.round(2)
        self.status = Order.statuses[:in_progress]
        self.save!
    end

    def change_status(status)
        self.update(status: status)
    end
end
