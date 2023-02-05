
class ThreeStrawberriesSpecialOfferHandler < SpecialOfferHandler

  PRICE_DROP = 4.50

  # Return a CartItemCheckout
  def apply(cart_item)

    cart_checkout_item = CartCheckoutItem.new(cart_item)

    if isSpecialOfferApply(cart_item)
      Rails.logger.info "Applying Special Offer when buying more than 3 strawberries"
      cart_checkout_item.total_price = cart_checkout_item.total_price - PRICE_DROP
    end
    cart_checkout_item
  end

  # Offer only for Tea
  def isSpecialOfferApply(cart_item)
    cart_item.product.code == "SR1" && cart_item.quantity >= 3
  end

end