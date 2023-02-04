class ShoppingCart
  attr_accessor :products

  def initialize
    @products = []
  end


  def total_price
    result = 0
    products.each do |product|
      result = result + product.price
    end
    result
  end

end
