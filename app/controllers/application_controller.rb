class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_render_cart
  before_action :initialize_cart
  before_action :set_locale

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart ||= Cart.find_or_create_by(user: current_user)

    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    else
      session[:cart_id] = @cart.id
    end
  end


  private

  def user_not_authorized
    flash[:alert] = "Only sellers are authorized to perform this action."
    redirect_to products_path
  end

  def set_locale
     if user_signed_in?
       I18n.locale = current_user.locale
     else
       I18n.locale = I18n.default_locale
     end
     Rails.logger.info("CURRENT LOCALE #{I18n.locale}")

  end
end
