module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, if: :devise_controller?

    def create
      super do |user|
        if user.persisted?
          Users::Confirmation::EmailMailer.confirm_mail(user).deliver_now
          # role_name = params[:user][:role] || Role::USER
          # role = Role.find_by(name: role_name)
          # user.add_role(role) if role
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