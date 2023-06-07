ActiveAdmin.register Account do
  permit_params :user_id, :user_type, :job_type, :job_title, :name, :monthly_salary, :manager_id, :email,
  :password, :date_of_joining, :pf_status, :esic_status, :bank_name, :account_no, :ifsc_code, :address1, :address2, :address3,
  :date_of_birth, :gender, :phone_number, :aadhar_no, :pan, :aadhar_image, :pan_card_image, :qualification_image

    index do
      selectable_column
      id_column
      column "Name" do |obj|
        obj.name
      end
      column "Designation" do |obj|
       obj.job_title
      end 
      column "Phone", :phone_number
      actions name: "Action"

    end


  form do |f|
    f.inputs 'Official Details' do
      f.input :user_id, label: 'Employee_id'
      f.input :user_type
      f.input :job_type
      f.input :job_title
      f.input :name
      f.input :monthly_salary
      f.input :manager_id, as: :select, collection: Account.all.where(user_type: "manager")
      f.input :email, label: 'Official_email_address'
      f.input :password, as: :string, input_html: { class: 'password-field' }
      f.input :date_of_joining, as: :date_picker
      f.input :pf_status
      f.input :esic_status
    end

    f.inputs 'Bank Details' do
      f.input :bank_name
      f.input :account_no
      f.input :ifsc_code
    end

    f.inputs 'Personal Details' do
      f.input :address1
      f.input :address2
      f.input :address3
      f.input :date_of_birth, as: :date_picker
      f.input :gender
      f.input :phone_number
      f.input :aadhar_no
      f.input :pan
      f.input :aadhar_image, as: :file
      f.input :pan_card_image, as: :file
      f.input :qualification_image, as: :file
    end
    f.actions
  end

end
