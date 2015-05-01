class AddTimestampsToAlmaMaters < ActiveRecord::Migration
  def change
    add_column :alma_maters, :created_at, :datetime
    add_column :alma_maters, :updated_at, :datetime
  end
end
