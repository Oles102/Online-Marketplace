class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_orderable, only: [:remove]

  def show
    @render_cart = true
  end

  def add
    @product = Product.find_by(id: params[:id])
    @quantity = params[:quantity].to_i

    if @quantity <= 0
      @cart.orderables.where(quantity: 0).destroy_all
    else
      Carts::AddToCartService.call(@cart, @product, @quantity)
    end

    redirect_to cart_path
  end

  def remove
    Carts::RemoveCartService.call(@orderable)
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def set_orderable
    @orderable = @cart.orderables.find_by(id: params[:id])
    redirect_to cart_path, alert: "Orderable not found" unless @orderable
  end

end
