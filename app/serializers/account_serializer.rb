class AccountSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :user_id,
    :user_type,
    :job_type,
    :job_title,
    :name,
    :monthly_salary,
    :manager_id,
    :email,
    :date_of_joining
    
  ]
end
