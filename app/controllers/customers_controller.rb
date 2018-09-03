class CustomersController < ApplicationController
  before_action :set_company
  before_action :set_company_customer, only: [:show, :update, :destroy]

  # GET /companies/:company_id/customers
  def index
    json_response(@company.customers)
  end

  # GET /companies/:company_id/customers/:id
  def show
    json_response(@customer)
  end

  # POST /companies/:company_id/customers
  def create
    @company.customers.create!(customer_params)
    json_response(@company, :created)
  end

  # PUT /companies/:company_id/customers/:id
  def update
    @customer.update(customer_params)
    head :no_content
  end

  # DELETE /companies/:company_id/customers/:id
  def destroy
    @customer.destroy
    head :no_content
  end

  private

  def customer_params
    params.permit(:name, :email)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_company_customer
    @customer = @company.customers.find_by!(id: params[:id]) if @company
  end
end