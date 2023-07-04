module Users
  module Confirmation
    class EmailMailer < ApplicationMailer
      def confirm_mail(user)
        @user = user

        mail(to: @user.email, subject: 'Welcome')
      end
    end
  end
end