require "test_helper"
require 'minitest/autorun'

class TestShoppingCartTest < Minitest::Test
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_empty_shopping_cart

    shopping_cart = ShoppingCart.new


    assert shopping_cart.total_price == 0



  end


end
