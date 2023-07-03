require 'rails_helper'

RSpec.describe Users::Confirmation::SendMailWorker, type: :worker do
  describe '#perform' do
    it 'calls SendMail service' do
      user = create(:user)
      expect(Users::Confirmation::SendMail).to receive(:call).with(user.id)

      Users::Confirmation::SendMailWorker.new.perform(user.id)
    end
  end
end
