# frozen_string_literal: true

module Admin
  class GasContractsController < ApplicationController
    def index
      @contracts = GasContract.all.sort_by(&:supplier)
    end

    def show
      @contract = GasContract.find(params[:id])
    end

    def new
      @contract = GasContract.new
    end

    def create
      my_params = params[:gas_contract]
      @contract = GasContract.new(supplier: my_params[:supplier],
                                  offer_name: my_params[:offer_name],
                                  subscription_base_price_month: my_params[:subscription_base_price_month],
                                  kwh_price_base: my_params[:kwh_price_base],
                                  low_kw_consumption_per_year: my_params[:low_kw_consumption_per_year],
                                  high_kw_consumption_per_year: my_params[:high_kw_consumption_per_year])
      if @contract.save
        flash[:success] = 'Contract created'
        redirect_to admin_gas_contracts_path
      else
        render 'new'
      end
    end

    def edit
      @contract = GasContract.find(params[:id])
    end

    def update
      @contract = GasContract.find(params[:id])
      if @contract.update(contract_params)
        redirect_to admin_gas_contract_path
      else
        render 'edit'
      end
    end

    def destroy
      @contract = GasContract.find(params[:id])
      @contract.destroy
      flash[:success] = 'Gaz contract successfully deleted'
      redirect_to admin_gas_contracts_path
    end

    private

    def contract_params
      params.require(:gas_contract).permit(:supplier,
                                           :offer_name,
                                           :subscription_base_price_month,
                                           :kwh_price_base,
                                           :low_kw_consumption_per_year,
                                           :high_kw_consumption_per_year)
    end
  end
end
