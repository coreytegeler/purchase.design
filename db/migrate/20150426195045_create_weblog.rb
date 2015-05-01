class CreateWeblog < ActiveRecord::Migration
  def change
    create_table :weblog do |t|
    	t.string "title"
    	t.text "body"
    	t.string "type"
    	t.integer "position"
    end
  end
end
