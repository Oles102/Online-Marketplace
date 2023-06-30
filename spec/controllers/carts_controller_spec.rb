# require 'rails_helper'
#
# RSpec.describe CartsController, type: :controller do
#   describe 'GET #show' do
#     it 'renders the show template' do
#       get :show
#       expect(response).to render_template(:show)
#     end
#
#     it 'sets @render_cart to true' do
#       get :show
#       expect(assigns(:render_cart)).to be true
#     end
#   end
#
#   describe 'POST #add' do
#     let(:product) { create(:product) }
#
#     context 'when quantity is greater than 0' do
#       it 'creates a new orderable and redirects to carts_path' do
#         post :add, params: { id: product.id, quantity: 2 }
#         expect(response).to redirect_to(carts_path)
#         expect(Orderable.count).to eq(1)
#       end
#     end
#
#     context 'when quantity is 0' do
#       it 'destroys the existing orderable and redirects to carts_path' do
#         orderable = create(:orderable, product: product)
#         post :add, params: { id: product.id, quantity: 0 }
#         expect(response).to redirect_to(carts_path)
#         expect(Orderable.count).to eq(0)
#       end
#     end
#
#     context 'when quantity is less than 0' do
#       it 'does not create a new orderable and redirects to carts_path' do
#         post :add, params: { id: product.id, quantity: -1 }
#         expect(response).to redirect_to(carts_path)
#         expect(Orderable.count).to eq(0)
#       end
#     end
#   end
#
#   describe 'DELETE #remove' do
#     let(:orderable) { create(:orderable) }
#
#     it 'destroys the orderable and redirects to carts_path' do
#       delete :remove, params: { id: orderable.id }
#       expect(response).to redirect_to(carts_path)
#       expect(Orderable.count).to eq(0)
#     end
#   end
# end