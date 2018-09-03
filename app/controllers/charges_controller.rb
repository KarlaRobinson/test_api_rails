class ChargesController < ApplicationController
  before_action :set_company
  before_action :set_company_charge, only: [:show, :update, :destroy]

  # GET /companies/:company_id/charges
  def index
    json_response(@company.charges)
  end

  # GET /companies/:company_id/charges/:id
  def show
    json_response(@charge)
  end

  # POST /companies/:company_id/charges
  def create
    @company.charges.create!(charge_params)
    json_response(@company, :created)
  end

  # PUT /companies/:company_id/charges/:id
  def update
    @charge.update(charge_params)
    head :no_content
  end

  # DELETE /companies/:company_id/charges/:id
  def destroy
    @charge.destroy
    head :no_content
  end

  private

  def charge_params
    params.permit(:amount, :payment_type)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_company_charge
    @charge = @company.charges.find_by!(id: params[:id]) if @company
  end
end