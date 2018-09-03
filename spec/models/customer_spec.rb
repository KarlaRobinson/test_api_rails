require 'rails_helper'

RSpec.describe Customer, type: :model do
  # Association test
  # ensure a customer record belongs to a single company record
  it { should belong_to(:company) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
