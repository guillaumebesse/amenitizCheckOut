require "test_helper"
require 'minitest/autorun'


# Simple test for CartItems. No special offers here

class TestCartItem < Minitest::Test

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
    cart = CartItems.new
    assert cart.total_price == 0
  end


  def test_cart_one_product
    cart = CartItems.new

    # quantity=1
    cart.add_product(@products[:green_tea])
    assert_equal @products[:green_tea].price, cart.total_price

    # quantity=3
    cart_item = cart.cart_item_by_product_code(@products[:green_tea].code)
    cart_item.quantity = 3
    assert_equal @products[:green_tea].price * 3, cart.total_price
  end


  def test_cart_two_products
    cart = CartItems.new
    cart.add_product(@products[:green_tea], 2)
    cart.add_product(@products[:coffee], 3)
    assert_equal @products[:green_tea].price*2 + @products[:coffee].price*3, cart.total_price
  end


  def test_cart_multiple_products
    cart = CartItems.new
    cart.add_product(@products[:green_tea], 2)
    cart.add_product(@products[:coffee], 3)
    cart.add_product(@products[:strawberries], 2)
    assert cart.total_price == @products[:green_tea].price*2 + @products[:coffee].price*3 + @products[:strawberries].price*2
  end


end
