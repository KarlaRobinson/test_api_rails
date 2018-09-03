class Customer < ApplicationRecord
  # model associations
  belongs_to :company

  #validations
  validates_presence_of :name, :email
end
