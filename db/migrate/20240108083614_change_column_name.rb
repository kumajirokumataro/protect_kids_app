class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :free_posts, :group, :kind
  end
end
