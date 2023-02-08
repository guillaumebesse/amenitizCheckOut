
class StrawberriesSpecialOfferHandler < SpecialOfferHandler

  PRICE_DROP = 4.50

  # Return a CartItemCheckout
  def apply(cart_item)

    cart_checkout_item = CartCheckoutItem.new(cart_item)

    if isSpecialOfferApply(cart_item)
      Rails.logger.info "Applying Special Offer when buying more than 3 strawberries"
      cart_checkout_item.total_price = (cart_checkout_item.quantity * PRICE_DROP).round(2)
      cart_checkout_item.has_special_offer = true
      cart_checkout_item.savings = (cart_item.total_price - cart_checkout_item.total_price).round(2)
      cart_checkout_item.description = "Special Offer when buying more than 3 strawberries, price drop to #{PRICE_DROP}. Savings €#{cart_checkout_item.savings}"
    end
    cart_checkout_item
  end

  # Offer only for Strawberries with 3 or more products
  def isSpecialOfferApply(cart_item)
    cart_item.product.code == "SR1" && cart_item.quantity >= 3
  end

end