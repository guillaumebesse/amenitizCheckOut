
class CartCheckoutItem
  attr_accessor :cart_item, :free_products, :discount, :quantity, :total_price

  def initialize(cart_item, discount=0, free_products=[])
    @cart_item = cart_item
    @free_products = free_products
    @discount = discount
    @quantity = cart_item.quantity
    @total_price = cart_item.total_price
  end

end
