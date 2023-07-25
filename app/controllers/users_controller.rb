class UsersController < ApplicationController
  include Reviewable
  before_action :authenticate_user!, only: %i[create update destroy]

  before_action :set_user, only: %i[show]

  def show
    @reviews = @user.reviews.includes(:user).order created_at: :desc
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
