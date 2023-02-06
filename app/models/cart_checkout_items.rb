class CartCheckoutItems
  attr_accessor :total_price
  attr_reader :checkout_items, :special_offer_handlers

  def initialize(cart_items)
    @checkout_items = []
    @total_price = 0
    @cart_items = cart_items
    @special_offer_handlers = initSpecialOfferHandlers
    apply(@cart_items.items)
  end


  def total_price
    result = 0
    @checkout_items.each do |cart_checkout_item|
      result = result + cart_checkout_item.total_price
    end
    result.round(2)
  end


  # Total quantity of products, including free products
  def total_quantity
    result = 0
    @checkout_items.each do |cart_checkout_item|
      result = result + cart_checkout_item.quantity
    end
    result
  end


  private

  def initSpecialOfferHandlers
    result = []
    result << GreenTeaSpecialOfferHandler.new
    result << StrawberriesSpecialOfferHandler.new
    result << CoffeeSpecialOfferHandler.new
  end


  def apply(cart_items)
    cart_items.each do |cart_item|
      has_special_offer = false
      @special_offer_handlers.each do |special_offer_handler|
        if special_offer_handler.isSpecialOfferApply(cart_item)
          @checkout_items << special_offer_handler.apply(cart_item)
          has_special_offer = true
          break # Only one special offer per cart_item
        end
      end

      if !has_special_offer
        Rails.logger.info "No Special Offer for #{cart_item.product.code}"
        @checkout_items << CartCheckoutItem.new(cart_item)
      end

    end
  end


end
