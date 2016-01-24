class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name,       null: false
      t.string :email,      null: false, default: ""
      t.string :sign_in_id, null: false

      t.timestamps
    end

    add_index :users, :sign_in_id, unique: true
  end
end
