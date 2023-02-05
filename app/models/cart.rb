class Cart
  attr_accessor :cart_items

  def initialize
    @cart_items = []
  end

  def add_product(product, quantity=1)
    cart_item = cart_item_by_product_code(product.code)

    if cart_item == nil
      cart_item = CartItem.new(product, 0)
      @cart_items << cart_item
    end

    cart_item.quantity = cart_item.quantity + quantity
  end

  def cart_item_by_product_code(product_code)
    @cart_items.find{ |cart_item|  cart_item.product.code == product_code }
  end


  def total_price
    result = 0
    @cart_items.each do |shopping_cart_item|
      result = result + shopping_cart_item.product.price * shopping_cart_item.quantity
    end
    result
  end

end
