class ForgotPasswordMailer < ApplicationMailer
	def otp_email
		@otp = params[:otp]
		mail(to: params[:email], subject: 'Password Reset OTP')
	end

end
