require 'rails_helper'

RSpec.describe Charge, type: :model do
  # Association test
  # ensure a charge record belongs to a single company record
  it { should belong_to(:company) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:payment_type) }
end
