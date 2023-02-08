

class CoffeeSpecialOfferHandler < SpecialOfferHandler

  DROP_PRICE_RATIO = Rational(2, 3)

  # Return a CartItemCheckout
  def apply(cart_item)

    cart_checkout_item = CartCheckoutItem.new(cart_item)

    if isSpecialOfferApply(cart_item)
      Rails.logger.info "Applying Special Offer when buying more than 3 coffees"
      cart_checkout_item.total_price = (cart_checkout_item.total_price * DROP_PRICE_RATIO.to_f).round(2)
      cart_checkout_item.has_special_offer = true
      cart_checkout_item.savings = (cart_item.total_price - cart_checkout_item.total_price).round(2)
      cart_checkout_item.description = "Special Offer: when buying more than 3 coffees, price drop to #{Rational(2, 3)}. Savings €#{cart_checkout_item.savings}"
    end
    cart_checkout_item
  end

  # Offer only for Coffee with 3 or more products
  def isSpecialOfferApply(cart_item)
    cart_item.product.code == "CF1" && cart_item.quantity >= 3
  end

end
