
class GreenTeaSpecialOfferHandler < SpecialOfferHandler

  # Return a CartItemCheckout
  def apply(cart_item)

    cart_checkout_item = CartCheckoutItem.new(cart_item)

    if isSpecialOfferApply(cart_item)
      Rails.logger.info "Applying a buy one get one Green Tea Special Offer"

      nb_free_products = cart_item.quantity
      free_products = []

      nb_free_products.times do
        free_products << ProductService.get_by_code(cart_item.product.code)
        cart_checkout_item.quantity = cart_checkout_item.quantity + 1
      end

      cart_checkout_item.free_products = free_products

    end
    cart_checkout_item
  end

  # Offer only for Tea
  def isSpecialOfferApply(cart_item)
    cart_item.product.code == "GR1"
  end

end