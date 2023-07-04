module Carts
  class CartService
    def self.call(cart, product = nil, quantity = nil)
      new(cart, product, quantity).call
    end

    def initialize(cart, product = nil, quantity = nil)
      @cart = cart
      @product = product
      @quantity = quantity
    end

    def call
      update_cart if product && quantity
      fetch_cart_data
    end

    private

    attr_reader :cart, :product, :quantity

    def update_cart
      current_orderable = cart.orderables.find_by(product_id: product.id)

      if current_orderable && quantity > 0
        current_orderable.update(quantity: quantity)
      elsif current_orderable && quantity <= 0
        current_orderable.destroy
      elsif !current_orderable && quantity > 0
        cart.orderables.create(product: product, quantity: quantity)
      end
    end

    def fetch_cart_data
      {
        orderables_count: cart.orderables.count,
        total_price: cart.total
      }
    end
  end
end
