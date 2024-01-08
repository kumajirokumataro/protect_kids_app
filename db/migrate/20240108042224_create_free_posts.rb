class CreateFreePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :free_posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :group, null: false, default: 0
      t.integer :target_child_age, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
