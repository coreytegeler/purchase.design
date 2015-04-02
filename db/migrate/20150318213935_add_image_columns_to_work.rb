class AddImageColumnsToWork < ActiveRecord::Migration
  def self.up
    add_attachment :works, :image
  end

  def self.down
    remove_attachment :works, :image
  end
end
