require 'rails'

module FileTestHelper

  def read_products_from_files
    path = File.join(Rails.root, "test/models", "product_lists.yml")
    products_yml = YAML.load_file(path)
    products = Hash.new
    products_yml.each do |key, product|
      products[key.to_sym] = Product.new(product["name"], product["code"], product["price"])
    end
    products
  end

end
