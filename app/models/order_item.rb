class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :list_price, presence: true, numericality: { greater_than: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    (list_price * quantity * (1 - discount/100)).round(2)
  end

  def funca(x)
    '2'
  end

  def funcb(a, b)
    a + b
  end
end
