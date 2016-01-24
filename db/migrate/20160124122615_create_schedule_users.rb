class CreateScheduleUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_users do |t|
      t.integer :schedule_id
      t.integer :user_id
      t.integer :status
      t.text :note

      t.timestamps
    end

    add_index :schedule_users, :schedule_id
  end
end
