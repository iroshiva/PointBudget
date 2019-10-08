# frozen_string_literal: true

module Admin
  class BoxContractsController < ApplicationController
    def index
      @contracts = BoxContract.all.sort_by(&:supplier)
    end

    def show
      @contract = BoxContract.find(params[:id])
    end

    def new
      @contract = BoxContract.new
    end

    def create
      my_params = params[:box_contract]
      @contract = BoxContract.new(supplier: my_params[:supplier],
                                  offer_name: my_params[:offer_name],
                                  price_month: my_params[:price_month],
                                  commitment: my_params[:commitment],
                                  price_after: my_params[:price_after],
                                  internet_type: my_params[:internet_type],
                                  downstream: my_params[:downstream],
                                  upstream: my_params[:upstream],
                                  tv_channel: my_params[:tv_channel],
                                  tv: my_params[:tv],
                                  call_fix_fr: my_params[:call_fix_fr],
                                  call_mobile_fr: my_params[:call_mobile_fr],
                                  call_foreign: my_params[:call_foreign],
                                  opening_fee: my_params[:opening_fee],
                                  termination_fee: my_params[:termination_fee],
                                  taken_termination: my_params[:taken_termination])
      if @contract.save
        flash[:success] = 'Contract created'
        redirect_to admin_box_contracts_path
      else
        render 'new'
      end
    end

    def edit
      @contract = BoxContract.find(params[:id])
    end

    def update
      @contract = BoxContract.find(params[:id])
      if @contract.update(contract_params)
        redirect_to admin_box_contracts_path
      else
        redirect_to admin_box_contract_path(@contract)
      end
    end

    def destroy
      @contract = BoxContract.find(params[:id])
      @contract.destroy
      flash[:success] = 'Contract successfully deleted'
      redirect_to admin_box_contracts_path
    end

    private

    def contract_params
      params.require(:box_contract).permit(:supplier,
                                           :offer_name,
                                           :price_month,
                                           :commitment,
                                           :price_after,
                                           :internet_type,
                                           :downstream,
                                           :upstream,
                                           :tv_channel,
                                           :tv,
                                           :call_fix_fr,
                                           :call_mobile_fr,
                                           :call_foreign,
                                           :opening_fee,
                                           :termination_fee,
                                           :taken_termination)
    end
  end
end
