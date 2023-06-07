require 'rails_helper'

RSpec.describe "Accounts", type: :request do
	describe "POST #login" do
    it "returns a success response with valid credentials" do
      account = create(:account, email: "test@example.com", password: "password")
      post '/login', params: { email: "test@example.com", password: "password" }
      expect(response.body).to include(account.email)
      expect(response.body).to include("token")
    end

    it "returns an error response with invalid credentials" do
      post '/login', params: { email: "invalid@example.com", password: "password" }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include("Invalid email or password")
    end
  end

  describe "POST #forgot_password" do
    it "sends reset password OTP to the user's email" do
      account = create(:account, email: "test@example.com")
      post '/forgot_password', params: { email: "test@example.com" }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Reset password OTP sent to your email")
      expect(account.reload.reset_password_token).to be_present
      expect(ActionMailer::Base.deliveries.count).to eq(1) # Assuming you're using ActionMailer
    end

    it "returns an error response when user not found" do
      post '/forgot_password', params: { email: "invalid@example.com" }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("User not found")
    end
  end

  describe "POST #reset_password" do
    it "resets the user's password with valid OTP" do
      account = create(:account, reset_password_token: "123456", email: "test@example.com")
      post '/reset_password', params: { otp: "123456", email: "test@example.com", password: "new_password" }
      expect(response).to have_http_status(:success)
      # expect(response.body).to include("Your password has been successfully reset!")
      expect(account.reload.reset_password_token).to be_nil
      expect(session[:user_id]).to eq(account.id)
    end

    it "returns an error response with invalid OTP" do
      account = create(:account, reset_password_token: "123456", email: "test@example.com")
      post '/reset_password', params: { otp: "654321", email: "test@example.com", password: "new_password" }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Link not valid or expired. Try generating a new link.")
      expect(account.reload.reset_password_token).to eq("123456")
    end

    it "returns an error response when user not found" do
      post '/reset_password', params: { otp: "123456", email: "invalid@example.com", password: "new_password" }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("Link not valid or expired. Try generating a new link.")
    end
  end
end
