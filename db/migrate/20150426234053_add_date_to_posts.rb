class AddDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :date, :datetime
  end
end
