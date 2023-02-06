
class CartCheckoutItem
  attr_accessor :cart_item, :free_products, :quantity, :total_price, :has_special_offer

  def initialize(cart_item)
    @cart_item = cart_item
    @free_products = []
    @quantity = cart_item.quantity
    @total_price = cart_item.total_price
    @has_special_offer = false
  end

end
