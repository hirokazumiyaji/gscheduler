class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string   :title,                 null: false
      t.datetime :start_at,              null: false
      t.datetime :end_at
      t.datetime :registration_start_at
      t.datetime :registration_end_at
      t.string   :place,                 null: false
      t.text     :note

      t.timestamps
    end

    add_index :schedules, :start_at
  end
end
