# frozen_string_literal: true

module Admin
  class BankContractsController < ApplicationController
    def index
      @contracts = BankContract.all.sort_by(&:supplier)
    end

    def show
      @contract = BankContract.find(params[:id])
    end

    def new
      @contract = BankContract.new
    end

    def create
      my_params = params[:bank_contract]
      @contract = BankContract.new(supplier: my_params[:supplier],
                                      group_name: my_params[:group_name],
                                      accounting_fees: my_params[:accounting_fees],
                                      inactive_accounting_fees: my_params[:inactive_accounting_fees],
                                      cheque:  my_params[:cheque],
                                      price_cheque: my_params[:price_cheque],
                                      price_order_cheque: my_params[:price_order_cheque],
                                      insurance_payment: my_params[:insurance_payment],
                                      sms_alert: my_params[:sms_alert],
                                      international_withdraw: my_params[:international_withdraw])
      if @contract.save
        flash[:success] = 'Contract created'
        redirect_to admin_bank_contracts_path
      else
        render 'new'
      end
    end

    def edit
      @contract = BankContract.find(params[:id])
    end

    def update
      @contract = BankContract.find(params[:id])
      if @contract.update(contract_params)
        redirect_to admin_bank_contracts_path
      else
        redirect_to admin_bank_contract_path(@contract)
      end
    end

    def destroy
      @contract = BankContract.find(params[:id])
      @contract.destroy
      flash[:success] = 'Contract successfully deleted'
      redirect_to admin_bank_contracts_path
    end

    private

    def contract_params
      params.require(:bank_contract).permit(:supplier,
                                           :group_name,
                                           :accounting_fees,
                                           :inactive_accounting_fees,
                                           :cheque,
                                           :price_cheque,
                                           :price_order_cheque,
                                           :insurance_payment,
                                           :sms_alert,
                                           :international_withdraw)
    end
  end
end
