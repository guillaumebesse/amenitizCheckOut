

class CheckoutController < ApplicationController

  def index
    logger.debug "Start home page "
    @products = StorageService.all_products

    cartItems = StorageService.get_cart_items(session)

    if !cartItems.nil?
      @cartItemsCheckout = CartCheckoutItems.new(cartItems)
    end
  end


  def add_to_cart
    logger.debug "Add to cart "

    product = StorageService.get_by_code(params[:product_code])

    cartItems = StorageService.get_cart_items(session)
    cartItems.add_product(product)

    StorageService.save_cart_items(cartItems, session)

    redirect_to "/"
  end


  def reset_cart
    logger.debug "Reset cart "
    StorageService.reset_cart_items(session)
    redirect_to "/"
  end


end