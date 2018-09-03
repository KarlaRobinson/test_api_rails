class Charge < ApplicationRecord
  # model associations
  belongs_to :company

  # validations
  validates_presence_of :amount, :payment_type
end
