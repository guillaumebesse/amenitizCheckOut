class ShoppingCart
  attr_accessor :shopping_cart_items

  def initialize
    @shopping_cart_items = []
  end

  def add_product(product, quantity=1)
    shopping_cart_item = shopping_cart_item_by_product_code(product.code)

    if shopping_cart_item == nil
      shopping_cart_item = ShoppingCartItem.new(product, 0)
      @shopping_cart_items << shopping_cart_item
    end

    shopping_cart_item.quantity = shopping_cart_item.quantity + quantity
  end

  def shopping_cart_item_by_product_code(product_code)
    @shopping_cart_items.find{ |cart_item|  cart_item.product.code == product_code }
  end


  def total_price
    result = 0
    @shopping_cart_items.each do |shopping_cart_item|
      result = result + shopping_cart_item.product.price * shopping_cart_item.quantity
    end
    result
  end

end
