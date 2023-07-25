class LocalesController < ApplicationController
  before_action :authenticate_user!

  def change_locale
    current_user.update(change_locale_permitted_params)

    render json: :ok
  end

  private

  def change_locale_permitted_params
    params.permit(:locale)
  end
end