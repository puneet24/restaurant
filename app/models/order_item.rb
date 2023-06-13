class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item

    def best_discount_offer(order_items)
        order_item_ids = order_items.map {|order_item| order_item.item_id}
        applicable_offers = self.item.offers.filter {|offer| offer.offer_type.eql?("item_offer") and  order_item_ids.include?(offer.required_item_id) }
        applicable_offers.max {|offer| offer.discount_rate }
    end

    def process_order_item(order_items)
        offer = self.best_discount_offer(order_items)
        self.applied_discount = offer ? offer.discount_rate : 0
        self.applied_tax_rate = self.item.tax_rate
        self.applied_price = self.item.price
        self.save!
        offer
    end

    def final_price
        discounted_price = self.applied_price - (self.applied_price * self.applied_discount/100)
        price = discounted_price + discounted_price * self.applied_tax_rate / 100
        price.round(2)
    end
end
