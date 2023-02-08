
class StorageService
  def self.all_products
    [
      Product.new("Green Tea", "GR1", 3.11),
      Product.new("Strawberries", "SR1", 5.00),
      Product.new("Coffee", "CF1", 11.23)
    ]
  end

  def self.get_by_code(code)
    self.all_products.find{ |product|  product.code == code }
  end


  def self.get_cart_items(session)
    result = session[:items]
    if result.nil?
      result = CartItems.new
    else
      result =  Marshal.load(result)
    end
    result
  end

  def self.save_cart_items(cart_items, session)
    session[:items] = Marshal.dump(cart_items)
  end

  def self.reset_cart_items(session)
    session[:items] = nil
  end


end