class CreateRoleMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :role_members do |t|
      t.integer :role_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :role_members, :role_id
    add_index :role_members, [:role_id, :user_id], unique: true
  end
end
