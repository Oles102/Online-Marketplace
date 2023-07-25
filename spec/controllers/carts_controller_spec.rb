require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }

    before { sign_in user }

    it 'renders the show template' do
      get :show
      expect(response).to render_template(:show)
    end

    it 'sets @render_cart to true' do
      get :show
      expect(assigns(:render_cart)).to be true
    end
  end

  describe 'POST #add' do
    let(:user) { create(:user) }
    let(:product) { create(:product) }

    before { sign_in user }

    context 'when quantity is greater than 0' do
      it 'creates a new orderable and redirects to cart_path' do
        expect {
          post :add, params: { id: product.id, quantity: 2 }
        }.to change(Orderable, :count).by(1)

        expect(response).to redirect_to(cart_path)
      end

    end

    context 'when quantity is 0' do
      it 'destroys the existing orderable and redirects to cart_path' do
        orderable = create(:orderable, product: product)
        post :add, params: { id: product.id, quantity: 0 }
        expect(response).to redirect_to(cart_path)
        expect(Orderable.count).to eq(1)
      end
    end

    context 'when quantity is less than 0' do
      it 'does not create a new orderable and redirects to cart_path' do
        post :add, params: { id: product.id, quantity: -1 }
        expect(response).to redirect_to(cart_path)
        expect(Orderable.count).to eq(0)
      end
    end
  end

  describe 'DELETE #remove' do
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }
    let!(:orderable) { create(:orderable, cart: cart) }

    before { sign_in user }

    it 'destroys the orderable and redirects to cart_path' do
      expect {
        delete :remove, params: { id: orderable.id }
      }.to change(Orderable, :count ).by(-1)

      expect(response).to redirect_to(cart_path)
    end
  end
end
