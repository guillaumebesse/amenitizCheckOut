require 'minitest/autorun'
require 'test_helper'


# Tests with mix of products and special offers


class TestCartItemsListsTest < Minitest::Test

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


  # TEST 1 | GR1,GR1 |  3.11€ |
  def test_assigment_test_1
    cart_items = CartItems.new
    cart_items.add_product(@products[:green_tea], 1)

    cart_checkout_items = CartCheckoutItems.new(cart_items)
    assert_equal 3.11, cart_checkout_items.total_price
    assert_equal 2, cart_checkout_items.total_quantity
    assert_equal cart_checkout_items.total_price + cart_checkout_items.savings, cart_checkout_items.total_price_without_offers
  end

  # TEST 2 | SR1,SR1,GR1,SR1 |  16.61€ |
  def test_assigment_test_2
    cart_items = CartItems.new
    cart_items.add_product(@products[:strawberries], 1)
    cart_items.add_product(@products[:strawberries], 1)
    cart_items.add_product(@products[:green_tea], 1)
    cart_items.add_product(@products[:strawberries], 1)

    cart_checkout_items = CartCheckoutItems.new(cart_items)

    assert_equal 16.61, cart_checkout_items.total_price
    assert_equal cart_checkout_items.total_price + cart_checkout_items.savings, cart_checkout_items.total_price_without_offers
  end


  # | GR1,CF1,SR1,CF1,CF1 |  30.57€ |
  def test_assigment_test_3
    cart_items = CartItems.new
    cart_items.add_product(@products[:green_tea], 1)
    cart_items.add_product(@products[:coffee], 1)
    cart_items.add_product(@products[:strawberries], 1)
    cart_items.add_product(@products[:coffee], 1)
    cart_items.add_product(@products[:coffee], 1)

    cart_checkout_items = CartCheckoutItems.new(cart_items)

    assert_equal 30.57, cart_checkout_items.total_price
    assert_equal cart_checkout_items.total_price + cart_checkout_items.savings, cart_checkout_items.total_price_without_offers
  end
end
