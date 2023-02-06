require "test_helper"
require 'minitest/autorun'


#
# Tests dealing with Special Offers
# No mix of products here



class TestCartCheckoutItemTest < Minitest::Test
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

  def test_green_tea_special_offer_handler
    buy_one_get_one_handler = GreenTeaSpecialOfferHandler.new

    # | GR1,GR1 |  3.11€ |
    cart_item_with_1_tea = CartItem.new(@products[:green_tea], 1)
    assert buy_one_get_one_handler.isSpecialOfferApply(cart_item_with_1_tea) == true
    assert_equal @products[:green_tea].price, buy_one_get_one_handler.apply(cart_item_with_1_tea).total_price
    assert_equal 2, buy_one_get_one_handler.apply(cart_item_with_1_tea).quantity

    cart_item_with_2_tea = CartItem.new(@products[:green_tea], 2)
    assert_equal true, buy_one_get_one_handler.isSpecialOfferApply(cart_item_with_2_tea)
    assert_equal 2*@products[:green_tea].price, buy_one_get_one_handler.apply(cart_item_with_2_tea).total_price
    assert_equal 4, buy_one_get_one_handler.apply(cart_item_with_2_tea).quantity
  end



  def test_three_strawberries_special_offer
    three_strawberries_special_offer_handler = StrawberriesSpecialOfferHandler.new

    cart_item_with_2_strawberries = CartItem.new(@products[:strawberries], 2)
    assert_equal false, three_strawberries_special_offer_handler.isSpecialOfferApply(cart_item_with_2_strawberries)

    cart_item_with_3_strawberries = CartItem.new(@products[:strawberries], 3)
    assert_equal true, three_strawberries_special_offer_handler.isSpecialOfferApply(cart_item_with_3_strawberries)
    assert_equal StrawberriesSpecialOfferHandler::PRICE_DROP * 3 , three_strawberries_special_offer_handler.apply(cart_item_with_3_strawberries).total_price
    assert_equal cart_item_with_3_strawberries.quantity, three_strawberries_special_offer_handler.apply(cart_item_with_3_strawberries).quantity
  end



  def test_three_coffees_special_offer
    three_coffees_special_offer_handler = CoffeeSpecialOfferHandler.new

    cart_item_with_2_coffees = CartItem.new(@products[:coffee], 2)
    assert_equal false, three_coffees_special_offer_handler.isSpecialOfferApply(cart_item_with_2_coffees)

    cart_item_with_3_coffees = CartItem.new(@products[:coffee], 3)
    assert_equal  true, three_coffees_special_offer_handler.isSpecialOfferApply(cart_item_with_3_coffees)
    assert_equal @products[:coffee].price * 3 * CoffeeSpecialOfferHandler::DROP_PRICE_RATIO, three_coffees_special_offer_handler.apply(cart_item_with_3_coffees).total_price
    assert_equal cart_item_with_3_coffees.quantity, three_coffees_special_offer_handler.apply(cart_item_with_3_coffees).quantity
  end


end
