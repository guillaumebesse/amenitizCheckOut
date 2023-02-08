# CartCheckoutItem is a class that is used to display the cart items in the checkout page.
# It is used to display the special offers. It is generated from the CartItems class and updated by SpecialOfferHandlers.
class CartCheckoutItem
  attr_accessor :cart_item, :free_products, :quantity, :total_price, :has_special_offer, :description, :savings

  def initialize(cart_item)
    @cart_item = cart_item
    @free_products = []
    @quantity = cart_item.quantity
    @total_price = cart_item.total_price
    @has_special_offer = false
    @savings = 0
  end


end
