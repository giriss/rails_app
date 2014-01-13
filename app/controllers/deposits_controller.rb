class DepositsController < ApplicationController

	before_action :login_check

	def set_express_checkout_paypal
		if get_deposit_params[:amount].to_f.round(2) < 10.00
			flash[:alerts] = "Deposit amount must be at least $10.00"
			redirect_to advertiser_wallet_path
		else
			@api = PayPal::SDK::Merchant::API.new
			@amount = get_deposit_params[:amount].to_f
			@total_amount_tmp = (@amount/0.97) + 0.3
			@total_amount = @total_amount_tmp.round(2)

			# Build request object
			@set_express_checkout = @api.build_set_express_checkout({
				:SetExpressCheckoutRequestDetails => {
					:ReturnURL => "http://localhost:3000#{deposits_do_express_checkout_paypal_path}",
					:CancelURL => "http://localhost:3000/",
					:PaymentDetails => [{
						:OrderTotal => {
							:currencyID => "USD",
							:value => "#{@total_amount}"
						},
						:ItemTotal => {
							:currencyID => "USD",
							:value => "#{@total_amount}"
						},
						:PaymentDetailsItem => [{
							:Name => "Deposit money to ily.io. An additional amount of $#{(@total_amount - @amount).round(2)} will be charged as PayPal fees.",
							:Quantity => 1,
							:Amount => {
								:currencyID => "USD",
								:value => "#{@total_amount}"
							},
							:ItemCategory => "Digital"
						}]
					}]
				}
			})

			@set_express_checkout_response = @api.set_express_checkout(@set_express_checkout)

			if @set_express_checkout_response.success?
				@token = @set_express_checkout_response.Token
				@redirect = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{@token}"
			else
				flash[:alerts] = @set_express_checkout_response.Errors.join("\n")
				@redirect = advertiser_wallet_path
			end

			redirect_to @redirect

		end

	end

	def do_express_checkout_paypal
		@token = params[:token]
		@payer_id = params[:PayerID]
		@api = PayPal::SDK::Merchant::API.new
		@get_express_checkout_details = @api.build_get_express_checkout_details({:Token => @token })
		@get_express_checkout_details_response = @api.get_express_checkout_details @get_express_checkout_details

		if @get_express_checkout_details_response.success?
			@amount_tmp = @get_express_checkout_details_response.GetExpressCheckoutDetailsResponseDetails.PaymentDetails[0].OrderTotal.value
			@amount = @amount_tmp.to_f.round(2)
			@do_express_checkout_payment = @api.build_do_express_checkout_payment({
				:DoExpressCheckoutPaymentRequestDetails => {
				:PaymentAction => "Sale",
				:Token => @token,
				:PayerID => @payer_id,
				:PaymentDetails => [{
					:OrderTotal => {
						:currencyID => "USD",
						:value => @amount
						},
					}]
				}
			})

			@do_express_checkout_payment_response = @api.do_express_checkout_payment @do_express_checkout_payment

			if @do_express_checkout_payment_response.success?
				@new_deposit = Deposit.new({:user_id => session[:user_id], :amount => @amount.round(2), :type => "paypal", :token => @token})
				@new_deposit.save
				flash[:deposit_success] = true
			else
				@log_error = ErrorLog.new({
					user_id: session[:user_id],
					detail: @do_express_checkout_payment_response.Errors.join,
					controller_action: "deposits#do_express_checkout_paypal"
				})
				@log_error.save
				flash[:alerts] = "Unknown error occurred.\nTry again in a few minutes\nIf error persists, contact support@ily.io"
			end
		else
			@log_error = ErrorLog.new({
				user_id: session[:user_id],
				detail: @get_express_checkout_details_response.Errors.join,
			    controller_action: "deposits#do_express_checkout_paypal"
			})
			@log_error.save
			flash[:alerts] = "Unknown error occurred.\nTry again in a few minutes\nIf error persists, contact support@ily.io"
		end

		redirect_to advertiser_wallet_path

	end

	def set_express_checkout_payza
		render text: get_deposit_params[:amount]
	end

	# - - - - - - - - - - - - - - PRIVATE DEF HERE - - - - - - - - - - - - - - #

	def get_deposit_params    # Private def
		params.require(:deposit).permit(:amount, :type)
	end

	def login_check
		if session[:user_id].nil? || session[:api_key].nil?
			redirect_to root_path
		else
			if session[:api_key] != User.find(session[:user_id]).get_api_key
				session.delete(:user_id)
				session.delete(:api_key)
				redirect_to root_path
			else
				@name = User.find(session[:user_id]).full_name
			end
		end
	end

	private :get_deposit_params, :login_check

end