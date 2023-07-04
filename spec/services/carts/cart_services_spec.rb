require 'rails_helper'

RSpec.describe Carts::CartService do
  describe '.call' do
    subject(:cart_service) { described_class.call(cart, product, quantity) }

    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:quantity) { 5 }

    context 'when updating cart with a product and quantity' do
      it 'updates the cart with the specified product and quantity' do
        cart_service

        expect(cart.orderables.count).to eq(1)
        expect(cart.total).to eq(product.price * quantity)
      end
    end

    context 'when updating cart with a product and zero quantity' do
      let!(:existing_orderable) { create(:orderable, cart: cart, product: product) }
      let(:quantity) { 0 }

      it 'removes the existing orderable from the cart' do
        cart_service

        expect(cart.orderables.count).to eq(0)
        expect(cart.total).to eq(0)
      end
    end

    context 'when updating cart without a product' do
      let(:product) { nil }
      let(:quantity) { 10 }

      it 'does not modify the cart' do
        cart_service

        expect(cart.orderables.count).to eq(0)
        expect(cart.total).to eq(0)
      end
    end

    context 'when updating cart without a quantity' do
      let(:quantity) { nil }

      it 'does not modify the cart' do
        cart_service

        expect(cart.orderables.count).to eq(0)
        expect(cart.total).to eq(0)
      end
    end
  end
end
