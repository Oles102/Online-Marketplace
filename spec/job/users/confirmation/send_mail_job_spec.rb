require 'rails_helper'

RSpec.describe Users::Confirmation::SendMailJob, type: :job do
  describe '#perform' do
    it 'calls SendMail service' do
      user = create(:user)
      expect(Users::Confirmation::SendMail).to receive(:call).with(user.id)

      Users::Confirmation::SendMailJob.perform_now(user.id)
    end
  end
end
