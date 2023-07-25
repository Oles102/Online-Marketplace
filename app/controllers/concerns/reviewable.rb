# app/controllers/concerns/reviewable.rb
module Reviewable
  extend ActiveSupport::Concern

  def load_product_reviews
    @product.reviews
  end

  def review_params
    params.require(:review).permit(:comment, :rating, :user_id, :reviewable_type, :reviewable_id)
  end

  def create_review
    @review = @product.reviews.build(review_params.merge(user_id: current_user.id))
    @review.save
  end

  def update_review(review)
    review.update(review_params.merge(user_id: current_user.id))
  end

  def destroy_review(review)
    review.destroy
  end
end
