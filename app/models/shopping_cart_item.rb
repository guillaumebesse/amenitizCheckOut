class ShoppingCartItem
  attr_accessor :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

  def total_price
    @product.price * @quantity
  end

end
