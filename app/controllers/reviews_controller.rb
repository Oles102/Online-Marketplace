# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  include Reviewable

  before_action :set_product, only: %i[edit update destroy create]
  before_action :set_review, only: %i[show edit update destroy]

  def show
    @reviews = load_product_reviews.order(created_at: :desc)
  end

  def edit
    authorize @review
  end

  def create
    if create_review
      redirect_to product_path(@product)
    else
      @reviews = load_product_reviews.order(created_at: :desc)
      render 'products/show'
    end
  end

  def update
    if update_review(@review)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    authorize @review
    destroy_review(@review)

    redirect_to product_path(@product)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
