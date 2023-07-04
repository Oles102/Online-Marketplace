require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) do
    { name: 'Product 1',
      price: 9.99,
      description: 'Test description',
      user_id: user.id,
      category_id: category.id }
  end

  let(:invalid_attributes) do
    { name: '',
      price: -5.0,
      description: 'Invalid description',
      user_id: user.id,
      category_id: category.id }
  end

  let(:user) { FactoryBot.create(:user) }
  before { user.add_role(:seller) }
  let(:category) { Category.create!(name: 'Category') }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      product = Product.create!(valid_attributes)
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'redirects to the edit page' do
      product = Product.create!(valid_attributes)
      allow(controller).to receive(:authorize).and_return(true) # Мокируем метод authorize, чтобы возвращал true
      get :edit, params: { id: product.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end


  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post :create, params: { product: valid_attributes }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new product' do
        expect {
          post :create, params: { product: invalid_attributes }
        }.to_not change(Product, :count)
      end

      it 'renders the new template' do
        post :create, params: { product: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end


  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Updated Product', price: 19.99, description: 'Updated description' }
      end

      it 'updates the requested product' do
        product = Product.create!(valid_attributes)
        patch :update, params: { id: product.id, product: new_attributes }
        product.reload
        expect(product.name).to eq(new_attributes[:name])
        expect(product.price).to eq(new_attributes[:price])
        expect(product.description).to eq(new_attributes[:description])
      end

      it 'redirects to the product' do
        product = Product.create!(valid_attributes)
        patch :update, params: { id: product.id, product: new_attributes }
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested product' do
        product = Product.create!(valid_attributes)
        patch :update, params: { id: product.id, product: invalid_attributes }
        product.reload
        expect(product.name).to_not eq(invalid_attributes[:name])
        expect(product.price).to_not eq(invalid_attributes[:price])
        expect(product.description).to_not eq(invalid_attributes[:description])
      end

      it 'renders the edit template' do
        product = Product.create!(valid_attributes)
        patch :update, params: { id: product.id, product: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authorized user' do
      it 'destroys the requested product if user is a seller' do
        product = FactoryBot.create(:product)
        user = product.user
        sign_in user
        allow(controller).to receive(:authorize).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        expect {
          delete :destroy, params: { id: product.id }
        }.to change(Product, :count).by(-1)
      end

      it 'does not destroy the requested product if user is not a seller' do
        product = FactoryBot.create(:product)
        user = FactoryBot.create(:user)
        sign_in user
        expect {
          delete :destroy, params: { id: product.id }
        }.not_to change(Product, :count)
      end
    end

    context 'when unauthorized user' do
      it 'does not destroy the product' do
        product = FactoryBot.create(:product)
        expect {
          delete :destroy, params: { id: product.id }
        }.not_to change(Product, :count)
      end
    end
  end




end
