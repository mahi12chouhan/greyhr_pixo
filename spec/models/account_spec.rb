require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "enums" do
    it { should define_enum_for(:user_type).with_values(manager: 0, employee: 1) }
    it { should define_enum_for(:job_type).with_values(Work_from_home: 0, Work_from_office: 1) }
    it { should define_enum_for(:job_title).with_values(ROR: 0, React_native: 1) }
  end

  describe "#generate_password_token!" do
    it "generates a password token and sets the reset password sent time" do
      account = Account.new
      account.generate_password_token!
      expect(account.reset_password_token).to be_present
      expect(account.reset_password_sent_at).to be_present
    end
  end

  describe "#reset_password" do
    it "resets the password and clears the reset password token" do
      account = Account.new(reset_password_token: "token")
      account.reset_password("new_password")
      expect(account.reset_password_token).to be_nil
      expect(account.password).to eq("new_password")
    end
  end
end
