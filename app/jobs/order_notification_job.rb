class OrderNotificationJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    order.change_status(Order.statuses[:completed]) if order.status.eql?(Order.statuses[:in_progress])
    # TODO
    # send mail & notification
  end
end
