class Account < ApplicationRecord
	
	enum user_type: { manager: 0, employee: 1 }
	enum job_type: { Work_from_home: 0, Work_from_office: 1, Hybrid: 2}
	enum job_title: { Ruby_on_Rails: 0, React_Native: 1, React_Js: 2, Human_Resource: 3, Software_Tester: 4, DevOPs_Developer: 5, Mean_Developer: 6, UI_UX_Designer: 7  }
	enum gender: { Male: 0, Female: 1, Other: 2}

	has_one_attached :aadhar_image
	has_one_attached :pan_card_image
	has_one_attached :qualification_image

	def generate_password_token(token)
		self.verify_token = token
		self.reset_password_token = generate_otp
		self.reset_password_sent_at = Time.now.utc
		save!
	end
	  	  
	def reset_password(password)
		self.reset_password_token = nil
		self.password = password
		save!
	end

	def generate_otp
		SecureRandom.random_number(100000..999999).to_s
	end
end
