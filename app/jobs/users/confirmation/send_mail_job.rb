module Users
  module Confirmation
    class SendMailJob < ApplicationJob
      def perform(user_id)
        SendMail.call(user_id)
      end
    end
  end
end