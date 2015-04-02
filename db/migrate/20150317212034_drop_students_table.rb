class DropStudentsTable < ActiveRecord::Migration
  def change
  	drop_table :groups_posts
  	drop_table :apply
  	drop_table :communities
  	drop_table :community
  	drop_table :areas
  	drop_table :faculties
  	drop_table :faculty
  end
end
