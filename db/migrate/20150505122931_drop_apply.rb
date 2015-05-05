class DropApply < ActiveRecord::Migration
  def change
  	drop_table "apply"
  end
end
