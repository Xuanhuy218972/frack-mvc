class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :order_date, presence: true
  belongs_to :user
  has_many :order_items

  before_save :run_my_custom_validate

  def run_my_custom_validate
    if required_date && order_date && required_date < order_date
      errors.add(:required_date, 'must be on or after order date')
    end
  end

  def status_text
    case status
    when 0
      'Pending'
    when 1
      'Processing'
    when 2
      'Shipped'
    when 3
      'Delivered'
    else
      'Unknown'
    end
  end
end


