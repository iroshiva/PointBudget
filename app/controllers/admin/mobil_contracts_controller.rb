module Admin
  class MobilContractsController < ApplicationController

  	def index
  		@contracts = MobilContract.all.sort_by(&:supplier)
  	end

  	def show
  		@contract = MobilContract.find(params[:id])
  	end

  	def new
  		@contract = MobilContract.new
  	end

  	def create
  		my_params = params[:mobil_contract]
      engagement = params[:engagement] == 'true' ? true : false
      add_phone = params[:add_phone] == 'true' ? true : false
      calls_france = params[:calls_france] == 'true' ? true : false
      calls_europe = params[:calls_europe] == 'true' ? true : false
      calls_international = params[:calls_international] == 'true' ? true : false
      net_international = params[:net_international] == 'true' ? true : false

  		@contract = MobilContract.new(supplier:my_params[:supplier],
                                  offer_name:my_params[:offer_name],
                                	line_service_price:my_params[:line_service_price],
                                  sim_card_price:my_params[:sim_card_price],
                                  engagement:engagement,
                                  add_phone:add_phone,
                                  bundle_price:my_params[:bundle_price],
                                  bundle_gbyte:my_params[:bundle_gbyte], 
                                  calls_france:calls_france,
                                  calls_europe:calls_europe,
                                  gbyte_europe:my_params[:gbyte_europe],
                                  calls_international:calls_international,
                                  net_international:net_international
                                  )
      if @contract.save
        flash[:success] = 'Contract Mobil created'
        redirect_to admin_mobil_contracts_path
      else
        render 'new'
      end
  	end

  	def edit
  		@contract = MobilContract.find(params[:id])
  	end

  	def update
  		@contract = MobilContract.find(params[:id])
      puts "#"*60
      puts params
      puts "#"*60
      if @contract.update(contract_params)
        flash[:success] = 'Contract Mobil edited'
        redirect_to admin_mobil_contracts_path
      else
        render 'edit'
      end
  	end

  	def destroy
  		@contract = MobilContract.find(params[:id])
      @contract.destroy
      flash[:success] = 'Mobil contract successfully deleted'
      redirect_to admin_mobil_contracts_path
  	end

  	private

    def contract_params
      params.require(:mobil_contract).permit(:supplier,
                                           :offer_name,
                                           :line_service_price,
                                           :sim_card_price,
                                           :engagement,
                                           :add_phone,
                                           :bundle_price,
                                           :bundle_gbyte,
                                           :calls_france,
                                           :calls_europe,
                                           :gbyte_europe,
                                           :calls_international,
                                           :net_international)
    end

  end
end