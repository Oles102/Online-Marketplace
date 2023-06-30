class CartsController < ApplicationController
  before_action :set_cart
  before_action :set_orderable, only: [:remove]

  def show
    @cart = current_user.cart
    @render_cart = true
    @cart_data = Carts::CartService.call(@cart)
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    Carts::CartService.call(@cart, @product, quantity)
    redirect_to cart_path
  end

  def remove
    @orderable.destroy
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(user_id: current_user.id)
  end

  def set_orderable
    @orderable = @cart.orderables.find(params[:id])
  end
end