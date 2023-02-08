# CartItems is a collection of CartItem objects. It is used to represent the cart without the special offers.
# It is now viewable by the user.
class CartItems
  attr_accessor :items

  def initialize
    @items = []
  end

  def add_product(product, quantity=1)
    cart_item = cart_item_by_product_code(product.code)

    if cart_item == nil
      cart_item = CartItem.new(product, 0)
      @items << cart_item
    end

    cart_item.quantity = cart_item.quantity + quantity
  end

  def cart_item_by_product_code(product_code)
    @items.find{ |cart_item|  cart_item.product.code == product_code }
  end

  def total_price
    result = 0
    @items.each do |shopping_cart_item|
      result = result + shopping_cart_item.total_price
    end
    result.round(2)
  end

end
