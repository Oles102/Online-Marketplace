require 'rails_helper'

describe 'Change locale', type: :request do
  describe 'PATCH locales#change_locale' do
    context 'when user logged in' do
      let(:user) { create(:user, locale: 'ru') }

      it 'changes locale' do
        sign_in(user)

        expect do
          patch '/change_locale', params: { locale: 'test' }
          user.reload
        end.to change(user, :locale).from('ru').to('test')

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user logged out' do
      it 'redirects to login page' do
        patch '/change_locale', params: { locale: 'test' }

        expect(response).to have_http_status(302)
        expect(response.location).to eq(new_user_session_url)
      end
    end
  end
end