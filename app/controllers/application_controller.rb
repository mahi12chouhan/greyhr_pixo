class ApplicationController < ActionController::Base
	
	def authenticate_employee
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