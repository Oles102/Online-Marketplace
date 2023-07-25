require 'rails_helper'

RSpec.describe Carts::AddToCartService do
  describe '.call' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    # Tests when the product is already in the cart

    context 'when the product is already in the cart' do
      let!(:existing_orderable) { cart.orderables.create(product: product, quantity: 3) }
      subject(:call_service) { described_class.call(cart, product, quantity) }

      context 'increases the quantity of the existing orderable' do
        let(:quantity) { 2 }

        it { expect { call_service }.to change { existing_orderable.reload.quantity }.by(quantity) }
      end

      context 'removes the orderable if new quantity is zero or negative' do
        let(:quantity) { -3 }

        it { expect { call_service }.to change { cart.orderables.count }.by(-1) }
      end

      context 'does not change the orderable if the new quantity is zero or negative but greater than the existing quantity' do
        let(:quantity) { -1 }

        it 'decreases the quantity' do
          expect { call_service }.to change { existing_orderable.reload.quantity }.by(quantity)
        end
      end
    end

    # Tests for when a product is not in the cart

    context 'when the product is not in the cart' do
      subject(:call_service) { described_class.call(cart, product, quantity) }

      context 'creates a new orderable with the specified quantity' do
        let(:quantity) { 5 }

        it 'creates a new orderable with the specified quantity' do
          expect { call_service }.to change { cart.orderables.count }.by(1)

          new_orderable = cart.orderables.last
          expect(new_orderable.product).to eq(product)
          expect(new_orderable.quantity).to eq(quantity)
        end
      end

      context 'does not create a new orderable if quantity is zero or negative' do
        let(:quantity) { 0 }

        it { expect { call_service }.not_to change { cart.orderables.count } }

        let(:negative_quantity) { -2 }

        it { expect { call_service }.not_to change { cart.orderables.count } }
      end
    end
  end
end
