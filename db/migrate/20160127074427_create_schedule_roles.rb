class CreateScheduleRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_roles do |t|
      t.integer :schedule_id
      t.integer :role_id

      t.timestamps
    end

    add_index :schedule_roles, :schedule_id
  end
end
