class DropCommunityAndEvents < ActiveRecord::Migration
  def change
  	drop_table 'visitors'
  	drop_table 'events'
  	drop_table 'groups'
  	drop_table 'people'
  	drop_table 'person_edits'
  	drop_table 'posts'
  	drop_table 'students'
  end
end
