class DropApply < ActiveRecord::Migration[4.2]
  def change
  	drop_table "apply"
  end
end
