class LeavesController < ApplicationController

	skip_before_action :verify_authenticity_token, only: [:apply_leave]
	 # before_action :authenticate_employee, only: [:apply_leave]

	def apply_leave
		byebug
		leave = Leave.new(leave_params)
		if leave.save
			render json: { message: 'Leave application created successfully' }, status: :created
		else
			render json: { errors: leaves.errors.full_messages }, status: :unprocessable_entity
		end
	end


	private

	def leave_params
		params.require(:leaves).permit(:date_to, :date_from, :leave_type, :description, :request_for_half_day)
    end


    # def authenticate_account
    #   @account = Account.find_by(id: @token&.id)

    #   if @account.present? #&& @token.try(:token_type).present? && @token.try(:token_type) =="login"
    #     @current_user ||Account.find_by(id: @token.id)
    #   else
    #     return render json: {errors: [
    #       {account: "#{t('application.account_not_found')}"},
    #     ]}, status: :not_found
    #   end
    # end

    def authenticate_employee
    	byebug
	    token = request.headers['Authorization']
	    decoded_token = decode_token(token)

	    if decoded_token
	      employee_id = decoded_token['employee_id']
	      @current_employee = Account.find_by(id: employee_id)
	    end

	    if @current_employee.nil?
	      render json: { error: 'Unauthorized' }, status: :unauthorized
	    end
    end
    def current_employee
    	@current_employee
    end

    def decode_token(token)
    	JWT.decode(token, Rails.application.secrets.secret_key_base).first
    rescue JWT::DecodeError, JWT::ExpiredSignature
    	nil
    end

end
