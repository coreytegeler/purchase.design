class CreateGroupsPostsJoin < ActiveRecord::Migration
  def change
    create_table :groups_posts , :id => false do |t|
    	t.integer "group_id"
    	t.integer "post_id"
    end
    add_index :groups_posts, ["group_id", "post_id"]
  end
end
