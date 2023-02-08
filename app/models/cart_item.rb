# The CartItem class is used to represent a product in the cart.
class CartItem
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

  def total_price
    (@product.price * @quantity).round(2)
  end

end
