class RenameABout < ActiveRecord::Migration
  def change
  	rename_table "about", "abouts"
  end
end
