require 'rails_helper'

RSpec.describe Company, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:customers).dependent(:destroy) }
  it { should have_many(:charges).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:activated) }
end
