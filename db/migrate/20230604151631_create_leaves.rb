class CreateLeaves < ActiveRecord::Migration[6.1]
  def change
    create_table :leaves do |t|
      t.date :date_to 
      t.date :date_from
      t.integer :leave_type
      t.text :description
      t.boolean :request_for_half_day

      t.timestamps
    end
  end
end
