
class CartCheckoutItem
  attr_accessor :cart_item, :free_products, :discount, :quantity, :total_price

  def initialize(cart_item)
    @cart_item = cart_item
    @free_products = []
    @discount = 0
    @quantity = cart_item.quantity
    @total_price = cart_item.total_price
  end

end
