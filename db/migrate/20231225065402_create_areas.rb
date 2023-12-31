class CreateAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :areas do |t|
      t.integer :name, null: false

      t.timestamps
    end
  end
end
