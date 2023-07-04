class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[edit create update new destroy]

  # GET /products or /products.json
    def index
     @products = Product.all
    end

  # GET /products/1 or /products/1.json
  def show
    @reviews = @product.reviews.order(created_at: :desc)
    @review = Review.new
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end


  # GET /products/1/edit
    def edit
      authorize @product
    end

  # POST /products or /products.json
    def create
      @product = current_user.products.build(product_params)
      authorize @product

      if @product.save
        redirect_to product_path(@product)
      else
        render :new
      end
    end

  # PATCH/PUT /products/1 or /products/1.json
    def update
      authorize @product

      if @product.update(product_params)
        redirect_to @product
      else
        render :edit
      end
    end


  # DELETE /products/1 or /products/1.json
    def destroy
      authorize @product

      @product = Product.find(params[:id])
      @product.destroy

      redirect_to products_path
    end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_product
      @product = Product.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def product_params
      params.require(:product).permit(:category_id, :name, :price, :description, :user_id, images: [])
  end
end





