class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale
  before_action :initialize_cart


  private
  def initialize_cart
    @cart = Cart.find_or_create_by(user: current_user)
    session[:cart_id] = @cart.id if @cart.present? && session[:cart_id].nil?
  end

  def user_not_authorized
    if user_signed_in?
      flash[:alert] = "Only sellers are authorized to perform this action."
      redirect_to products_path
    else
      flash[:alert] = "Please sign up or log in to perform this action."
      redirect_to new_user_registration_path
    end
  end

  def set_locale
    I18n.locale = if user_signed_in?
                    current_user.locale
                  else
                    I18n.default_locale
                  end
    Rails.logger.info("CURRENT LOCALE #{I18n.locale}")
  end
end
