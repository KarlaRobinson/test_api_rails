class Company < ApplicationRecord
  # model association
  has_many :customers, dependent: :destroy
  has_many :charges, dependent: :destroy

  # validations
  validates_presence_of :name, :category
  validates_inclusion_of :activated, in: [true, false]
end
