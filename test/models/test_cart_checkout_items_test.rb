require "test_helper"
require 'minitest/autorun'



class TestCartCheckoutItemsTest < Minitest::Test
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

  def test_buy_one_get_one
    buy_one_get_one_handler = BuyOneGetOneSpecialOfferHandler.new

    cart_item_with_1_tea = CartItem.new(@products[:tea], 1)
    assert buy_one_get_one_handler.isSpecialOfferApply(cart_item_with_1_tea) == true
    assert buy_one_get_one_handler.apply(cart_item_with_1_tea).total_price == 3.11
    assert buy_one_get_one_handler.apply(cart_item_with_1_tea).quantity == 2

    cart_item_with_2_tea = CartItem.new(@products[:tea], 2)
    assert buy_one_get_one_handler.isSpecialOfferApply(cart_item_with_2_tea) == true
    assert buy_one_get_one_handler.apply(cart_item_with_2_tea).total_price == 2*3.11
    assert buy_one_get_one_handler.apply(cart_item_with_2_tea).quantity == 4
  end




end
