class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :order_date, presence: true
  belongs_to :user

  before_save :run_my_custom_validate

  def run_my_custom_validate
    if required_date && order_date && required_date < order_date
      errors.add(:required_date, 'must be on or after order date')
    end
  end
end


