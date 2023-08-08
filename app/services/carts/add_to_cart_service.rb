module Carts
  class AddToCartService
    class << self
      def call(cart, product, quantity)
        current_orderable = cart.orderables.find_by(product_id: product.id)

        if current_orderable
          new_quantity = current_orderable.quantity + quantity
          if new_quantity <= 0
            current_orderable.destroy
          else
            current_orderable.update(quantity: new_quantity)
          end
        elsif quantity > 0
          cart.orderables.create(product: product, quantity: quantity)
        end
      end
    end
  end
end
