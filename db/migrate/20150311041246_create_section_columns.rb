class CreateSectionColumns < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string :name
    	t.string :slug
    	t.text :text
    end

    create_table :faculty do |t|
    	t.string :name
    	t.string :slug
    	t.text :text
    end

    create_table :community do |t|
    	t.string :name
    	t.string :slug
    	t.text :text
    end

    create_table :apply do |t|
    	t.string :name
    	t.string :slug
    	t.text :text
    end
  end
end
