module Users
  module Confirmation
    class SendMailWorker
      include Sidekiq::Worker

      sidekiq_options queue: :email_welcome

      def perform(user_id)
        SendMail.call(user_id)
      end
    end
  end
end
