class AddTimestampsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :created_at, :datetime
    add_column :resources, :updated_at, :datetime
  end
end
