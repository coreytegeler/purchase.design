class RenameABout < ActiveRecord::Migration[4.2]
  def change
  	rename_table "about", "abouts"
  end
end
