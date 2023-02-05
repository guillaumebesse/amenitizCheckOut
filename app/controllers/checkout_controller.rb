

class CheckoutController < ApplicationController

  def index
    logger.debug "Start home page "
    @products = ProductService.all_products
  end


end