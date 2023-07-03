class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_orderable, only: [:remove]

  def show
    @render_cart = true
    @cart_data = Carts::CartService.call(@cart)
  end

  def add
    @product = Product.find_by(id: params[:id])
    @quantity = params[:quantity].to_i

    if @quantity <= 0
      @cart.orderables.where(quantity: 0).destroy_all
    else
      Carts::CartService.call(@cart, @product, @quantity)
    end

    redirect_to cart_path
  end



  def remove
    @orderable = @cart.orderables.find_by(id: params[:id])
    if @orderable
      @orderable.destroy
    end
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(user_id: current_user.id)
  end

  def set_orderable
    @orderable = @cart.orderables.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: "Orderable not found"
  end

end