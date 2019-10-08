# frozen_string_literal: true

module Admin
  class EleContractsController < ApplicationController
    def index
      @contracts = EleContract.all.sort_by(&:supplier)
    end

    def show
      @contract = EleContract.find(params[:id])
    end

    def new
      @contract = EleContract.new
    end

    def create
      my_params = params[:ele_contract]
      @contract = EleContract.new(supplier: my_params[:supplier],
                                  offer_name: my_params[:offer_name],
                                  subscription_base_price_month: my_params[:subscription_base_price_month],
                                  kwh_price_base: my_params[:kwh_price_base],
                                  kVA_power: my_params[:kVA_power])
      if @contract.save
        flash[:success] = 'Contract created'
        redirect_to admin_ele_contracts_path
      else
        flash[:error] = @contract.errors.messages
        render 'new'
      end
    end

    def edit
      @contract = EleContract.find(params[:id])
    end

    def update
      @contract = EleContract.find(params[:id])
      if @contract.update(contract_params)
        redirect_to admin_ele_contract_path
      else
        render 'edit'
      end
    end

    def destroy
      @contract = EleContract.find(params[:id])
      @contract.destroy
      flash[:success] = 'Electricity contract successfully deleted'
      redirect_to admin_ele_contracts_path
    end

    private

    def contract_params
      params.require(:ele_contract).permit(:supplier,
                                           :offer_name,
                                           :subscription_base_price_month,
                                           :kwh_price_base,
                                           :kVA_power)
    end
  end
end
