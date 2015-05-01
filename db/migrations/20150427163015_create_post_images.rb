class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.attachment :image
      t.integer :post_id
      t.integer :position
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
