

class CheckoutController < ApplicationController

  def index
    @products = ProductService.all_products
  end


end