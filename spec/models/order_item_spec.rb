require 'spec_helper'

RSpec.describe OrderItem do
  describe '#funca' do
    # Thiết lập đối tượng
    let(:order_item) { OrderItem.new }
    it 'returns true' do
      expect(order_item.funca(1)).to be_truthy
    end
    it 'returns false' do
      expect(order_item.funca(0)).to be_truthy
    end
  end

  describe '#funcb' do
    it 'returns sum 2 num' do
      order_item = OrderItem.new
      expect(order_item.funcb(3, 5)).to eq(8) 
    end
    it 'raises a Error when add a num & a string' do
      order_item = OrderItem.new
      expect { order_item.funcb(3, '5') }.to raise_error(NameError)
    end
  end

  describe '#total_price' do
    it 'total amount (with discount)' do
      item = OrderItem.new(price: 100.0, qty: 2, disc: 10)
      expect(item.total_price).to eq(180.0)
    end

    it 'total amount (no discount)' do
      item = OrderItem.new(price: 50.0, qty: 3, disc: 0)
      expect(item.total_price).to eq(150.0)
    end

    it 'error: negative price' do
      order_item = OrderItem.new(list_price: -100.0, quantity: 1, discount: 0)
      expect(order_item).not_to be_valid
      expect(order_item.errors_on(:list_price)).not_to be_empty
    end

    it 'error: negative qty' do
      order_item = OrderItem.new(list_price: 100.0, quantity: -2, discount: 0)
      expect(order_item).not_to be_valid
      expect(order_item.errors_on(:quantity)).not_to be_empty
    end

    it 'error: negative discount' do
      order_item = OrderItem.new(list_price: 100.0, quantity: 1, discount: -5)
      expect(order_item).not_to be_valid
      expect(order_item.errors_on(:discount)).not_to be_empty
    end
  end
end