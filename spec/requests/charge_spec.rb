require 'rails_helper'

RSpec.describe 'Charges API' do
  # Initialize the test data
  let!(:company) { create(:company) }
  let!(:charges) { create_list(:charge, 20, company_id: company.id) }
  let(:company_id) { company.id }
  let(:id) { charges.first.id }

  # Test suite for GET /companies/:company_id/charges
  describe 'GET /companies/:company_id/charges' do
    before { get "/companies/#{company_id}/charges" }

    context 'when company exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all company charges' do
        expect(JSON.parse(response.body).size).to eq(20)
      end
    end

    context 'when company does not exist' do
      let(:company_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Company/)
      end
    end
  end

  # Test suite for GET /companies/:company_id/charges/:id
  describe 'GET /companies/:company_id/charges/:id' do
    before { get "/companies/#{company_id}/charges/#{id}" }

    context 'when company charge exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the charge' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when company charge does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Charge/)
      end
    end
  end

  # Test suite for PUT /companies/:company_id/charges
  describe 'POST /companies/:company_id/charges' do
    let(:valid_attributes) { { amount: 1080, payment_type: 'oxxo' } }

    context 'when request attributes are valid' do
      before { post "/companies/#{company_id}/charges", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/companies/#{company_id}/charges", params: {amount: 1933} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Payment type can't be blank/)
      end
    end
  end

  # Test suite for PUT /companies/:company_id/charges/:id
  describe 'PUT /companies/:company_id/charges/:id' do
    let(:valid_attributes) { { amount: 1832, payment_type: 'card' } }

    before { put "/companies/#{company_id}/charges/#{id}", params: valid_attributes }

    context 'when charge exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the charge' do
        updated_charge = Charge.find(id)
        expect(updated_charge.amount).to match(1832)
        expect(updated_charge.payment_type).to match(/card/)

      end
    end

    context 'when the charge does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Charge/)
      end
    end
  end

  # Test suite for DELETE /companies/:id
  describe 'DELETE /companies/:id' do
    before { delete "/companies/#{company_id}/charges/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end