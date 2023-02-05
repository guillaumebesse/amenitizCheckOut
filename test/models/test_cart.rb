require "test_helper"
require 'minitest/autorun'

class TestCart < Minitest::Test
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

  def test_empty_cart
    cart = Cart.new
    assert cart.total_price == 0
  end


  def test_cart_one_product
    cart = Cart.new

    # quantity=1
    cart.add_product(@products[:tea])
    assert cart.total_price == @products[:tea].price

    # quantity=3
    cart_item = cart.cart_item_by_product_code(@products[:tea].code)
    cart_item.quantity = 3
    assert cart.total_price == @products[:tea].price * 3
  end


  def test_cart_two_products
    cart = Cart.new
    cart.add_product(@products[:tea], 2)
    cart.add_product(@products[:coffee], 3)
    assert cart.total_price == @products[:tea].price*2 + @products[:coffee].price*3
  end


end
