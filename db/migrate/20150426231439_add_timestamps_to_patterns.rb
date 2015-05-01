class AddTimestampsToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :created_at, :datetime
    add_column :patterns, :updated_at, :datetime
  end
end
