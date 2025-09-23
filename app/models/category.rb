class Category < ActiveRecord::Base
  validates :name, presence: true

  before_save :run_my_custom_validate

  def run_my_custom_validate
    if name.to_s.strip.length < 3
      errors.add(:name, 'is too short (minimum is 3 characters)')
    end
  end
end

