require "test_helper"
require 'minitest/autorun'


#
# Test dealing with Special Offers
#


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

  def test_buy_one_get_one_with_green_tea
    buy_one_get_one_handler = BuyOneGetOneGreenTeaSpecialOfferHandler.new

    # | GR1,GR1 |  3.11€ |
    cart_item_with_1_tea = CartItem.new(@products[:tea], 1)
    assert buy_one_get_one_handler.isSpecialOfferApply(cart_item_with_1_tea) == true
    assert buy_one_get_one_handler.apply(cart_item_with_1_tea).total_price == @products[:tea].price
    assert buy_one_get_one_handler.apply(cart_item_with_1_tea).quantity == 2

    cart_item_with_2_tea = CartItem.new(@products[:tea], 2)
    assert buy_one_get_one_handler.isSpecialOfferApply(cart_item_with_2_tea) == true
    assert buy_one_get_one_handler.apply(cart_item_with_2_tea).total_price == 2*@products[:tea].price
    assert buy_one_get_one_handler.apply(cart_item_with_2_tea).quantity == 4
  end



  def test_three_strawberries_special_offer
    three_strawberries_special_offer_handler = ThreeStrawberriesSpecialOfferHandler.new

    cart_item_with_2_strawberries = CartItem.new(@products[:strawberries], 2)
    assert three_strawberries_special_offer_handler.isSpecialOfferApply(cart_item_with_2_strawberries) == false

    cart_item_with_3_strawberries = CartItem.new(@products[:strawberries], 3)
    assert three_strawberries_special_offer_handler.isSpecialOfferApply(cart_item_with_3_strawberries) == true
    assert three_strawberries_special_offer_handler.apply(cart_item_with_3_strawberries).total_price == @products[:strawberries].price * 3 - ThreeStrawberriesSpecialOfferHandler::PRICE_DROP
    assert three_strawberries_special_offer_handler.apply(cart_item_with_3_strawberries).quantity == cart_item_with_3_strawberries.quantity
  end






end
