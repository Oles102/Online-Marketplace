class CartsController < ApplicationController
  before_action :set_orderable, only: %i[ remove ]
  def show
    @render_cart = true
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable && quantity > 0
      current_orderable.update(quantity:)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity:)
      redirect_to carts_path
    end
  end
  def remove
    Orderable.find_by(id: params[:id]).destroy
    redirect_to carts_path
  end

end

    private
    # Use callbacks to share common setup or constraints between actions.
  def set_orderable
    @orderable = Orderable.find(params[:id])
  end

# class CartsController < ApplicationController
#   before_action :set_orderable, only: %i[remove]
#
#   def show
#     @render_cart = false
#   end
#
#   def add
#     @product = Product.find_by(id: params[:id])
#     quantity = params[:quantity].to_i
#     current_orderable = @cart.orderables.find_by(product_id: @product.id)
#     if current_orderable && quantity.positive?
#       current_orderable.update(quantity:)
#     elsif quantity <= 0
#       current_orderable.destroy
#     else
#       @cart.orderables.create(product: @product, quantity:)
#       redirect_to carts_path
#     end
#   end
#
#   def remove
#     @orderable.destroy
#     redirect_to carts_path
#   end
#
#   private
#
#   def set_orderable
#     @orderable = Orderable.find(params[:id])
#   end
# end