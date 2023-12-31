class CreateSelectings < ActiveRecord::Migration[6.1]
  def change
    create_table :selectings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
