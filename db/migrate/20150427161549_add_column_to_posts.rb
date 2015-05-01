class AddColumnToPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :date, :start_date
    add_column :posts, :end_date, :datetime
  end
end
