class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :gender, null: false, default: 0
      t.integer :age, null: false, default: 3
      t.string :nickname, null: false
      t.string :self_introduction
      t.boolean :admin, null: false, default: false

      t.timestamps
    end
  end
end
