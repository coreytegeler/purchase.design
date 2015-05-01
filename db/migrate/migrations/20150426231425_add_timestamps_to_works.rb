class AddTimestampsToWorks < ActiveRecord::Migration
  def change
    add_column :works, :created_at, :datetime
    add_column :works, :updated_at, :datetime
  end
end
