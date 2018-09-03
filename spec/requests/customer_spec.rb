require 'rails_helper'

RSpec.describe 'Customers API' do
  # Initialize the test data
  let!(:company) { create(:company) }
  let!(:customers) { create_list(:customer, 20, company_id: company.id) }
  let(:company_id) { company.id }
  let(:id) { customers.first.id }

  # Test suite for GET /companies/:company_id/customers
  describe 'GET /companies/:company_id/customers' do
    before { get "/companies/#{company_id}/customers" }

    context 'when company exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all company customers' do
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

  # Test suite for GET /companies/:company_id/customers/:id
  describe 'GET /companies/:company_id/customers/:id' do
    before { get "/companies/#{company_id}/customers/#{id}" }

    context 'when company customer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the customer' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when company customer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  # Test suite for PUT /companies/:company_id/customers
  describe 'POST /companies/:company_id/customers' do
    let(:valid_attributes) { { name: 'Julia Montes', email: 'julia@gmail.com' } }

    context 'when request attributes are valid' do
      before { post "/companies/#{company_id}/customers", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/companies/#{company_id}/customers", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /companies/:company_id/customers/:id
  describe 'PUT /companies/:company_id/customers/:id' do
    let(:valid_attributes) { { name: 'Juan Lopez', email: 'juan@hotmail.com' } }

    before { put "/companies/#{company_id}/customers/#{id}", params: valid_attributes }

    context 'when customer exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the customer' do
        updated_customer = Customer.find(id)
        expect(updated_customer.name).to match(/Juan Lopez/)
        expect(updated_customer.email).to match(/juan@hotmail.com/)

      end
    end

    context 'when the customer does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  # Test suite for DELETE /companies/:id
  describe 'DELETE /companies/:id' do
    before { delete "/companies/#{company_id}/customers/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end