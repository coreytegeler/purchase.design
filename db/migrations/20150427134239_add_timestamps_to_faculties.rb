class AddTimestampsToFaculties < ActiveRecord::Migration
  def change
    add_column :faculties, :created_at, :datetime
    add_column :faculties, :updated_at, :datetime
  end
end
