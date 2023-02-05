require "test_helper"
require 'minitest/autorun'

class TestShoppingCartTest < Minitest::Test
  def setup
    path = File.join(Rails.root, "test/models", "product_lists.yml")
    products_yml = YAML.load_file(path)
    @products = Hash.new
    products_yml.each do |key, product|
      @products[key.to_sym] = Product.new(product["name"], product["code"], product["price"])
    end
  end

  def teardown
    # Do nothing
  end

  def test_empty_shopping_cart
    shopping_cart = ShoppingCart.new
    assert shopping_cart.total_price == 0
  end


  def test_shopping_cart_one_product
    shopping_cart = ShoppingCart.new

    # quantity=1
    shopping_cart.add_product(@products[:tea])
    assert shopping_cart.total_price == @products[:tea].price

    # quantity=3
    shopping_cart_item = shopping_cart.shopping_cart_item_by_product_code(@products[:tea].code)
    shopping_cart_item.quantity = 3
    assert shopping_cart.total_price == @products[:tea].price * 3
  end


  def test_shopping_cart_two_products
    shopping_cart = ShoppingCart.new
    shopping_cart.add_product(@products[:tea], 2)
    shopping_cart.add_product(@products[:coffee], 3)
    assert shopping_cart.total_price == @products[:tea].price*2 + @products[:coffee].price*3
  end


end
