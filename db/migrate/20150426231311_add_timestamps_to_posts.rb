class AddTimestampsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
  end
end
