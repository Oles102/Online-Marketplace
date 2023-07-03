module Users
  module Confirmation
    class SendMail
      class << self
        def call(user_id)
          user = User.find(user_id)

          Users::Confirmation::EmailMailer.confirm_mail(user).deliver_now

        end
      end
    end
  end
end