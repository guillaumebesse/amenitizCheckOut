
class ProductService
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

end