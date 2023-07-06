require 'json_web_token'
class AccountsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:login, :forgot_password]
	# protect_from_forgery with: :null_session

	def login
		byebug
		employee = Account.find_by(email: params[:email], password: params[:password])
		if employee.present?
			payload = { user_id: employee.id }
			token = JsonWebToken.encode(payload)
			 render json: { employee: AccountSerializer.new(employee), token: token }, status: :created
		else
			render json: { error: 'Invalid email or password' }, status: :unauthorized
		end
	end

	
	 def forgot_password
        user = Account.find_by(email: params[:email])
        if user.present?
            verify_token = generate_token(user)
            user.generate_password_token(verify_token)
            send_otp_email(user.email, user.reset_password_token)
            # ForgotPasswordMailer.with(account: otp, email: user.email, host: request.base_url).send_otp.deliver
            render json: { token: verify_token , otp: user.reset_password_token }
        else
            render json: { error: 'User not found' }, status: :not_found
        end
    end    

    def reset_password
    	user = Account.find_by(reset_password_token: params[:otp], verify_token: params[:token])
    	if user.present?
    		if user.reset_password(params[:password])
    			render json: {
    				message: "Your password has been successfuly reset!"
    			}
    			session[:user_id] = user.id
    		else
    			render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    		end
    	else
    		render json: {error:  ['Otp not valid or expired. Try generating a new otp.']}, status: :not_found
    	end
    end
	private

	# def generate_token(employee)
	# 	payload = { employee_id: employee.id }
	# 	JWT.encode(payload, Rails.application.secrets.secret_key_base)
	# end
	
	def account_params
		params.require(:account).permit(:full_name, :job_type, :user_type, :email,:image)
    end       

    def send_otp_email(email, otp)
    	ForgotPasswordMailer.with(email: email, otp: otp).otp_email.deliver_now
    end	
end