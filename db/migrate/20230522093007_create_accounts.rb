class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :user_id
      t.integer :user_type
      t.integer :job_type
      t.integer :job_title
      t.string :name
      t.float :monthly_salary
      t.integer :manager_id
      t.string :email
      t.string :password
      t.date :date_of_joining
      t.string :pf_status
      t.string :esic_status
      t.string :bank_name
      t.string :account_no
      t.string :ifsc_code
      t.string :address1
      t.string :address2
      t.string :address3
      t.date :date_of_birth
      t.integer :gender
      t.string :phone_number
      t.string :aadhar_no
      t.integer :pan
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.string :verify_token
      t.timestamps
    end
  end
end
