class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :set_product, only: %i[edit update destroy create]

  def show
    @review = Review.find(params[:id])
    @reviews = load_product_reviews.order(created_at: :desc)
  end

  def edit
    authorize @review
  end

  # POST /reviews or /reviews.json
  def create
    @review = @product.reviews.new(review_params.merge(user_id: current_user.id))
    authorize @review
    if @review.save
      redirect_to product_path(@product)
    else
      @reviews = @product.reviews.order created_at: :desc
      render 'products/show'
    end
  end


  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    if @review.update(review_params.merge(user_id: current_user.id))
      redirect_to product_path(@product)
    else
      render :edit
    end
  end


  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    authorize @review
    @review.destroy

    redirect_to product_path(@product)
  end

  def load_product_reviews
    product = @review.reviewable
    @review.reviewable.try(:reviews) || Review.none
  end

  private


    # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def set_product
    @product = Product.find params[:product_id]
  end
    # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:comment, :rating, :user_id,
                                   :reviewable_type, :reviewable_id)
  end
end
