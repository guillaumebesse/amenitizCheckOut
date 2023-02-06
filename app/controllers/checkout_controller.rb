

class CheckoutController < ApplicationController

  def index
    logger.debug "Start home page "
    @products = ProductService.all_products

    cartItems = get_cartItems

    if !cartItems.nil?
      @cartItemsCheckout = CartCheckoutItems.new(cartItems)
    end
  end


  def add_to_cart
    logger.debug "Add to cart "

    product = ProductService.get_by_code(params[:product_code])

    cartItems = get_cartItems
    cartItems.add_product(product)

    save_cartItems(cartItems)

    redirect_to "/"
  end


  private

  def get_cartItems
    result = session[:items]
    if result.nil?
      result = CartItems.new
    else
      logger.debug "Found cart in cache"
      result =  Marshal.load(result)
    end
    result
  end

  def save_cartItems(cartItems)
    session[:items] = Marshal.dump(cartItems)
  end

end