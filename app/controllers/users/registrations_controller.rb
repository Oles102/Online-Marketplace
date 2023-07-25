module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def create
      super do |user|
        if user.persisted?
          Users::Confirmation::SendMailWorker.perform_async(user.id)
          user.add_role(params[:role]) if params[:role].present?
        end
      end
    end


    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[locale avatar other_attributes role])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[locale avatar other_attributes role])
    end
  end
end