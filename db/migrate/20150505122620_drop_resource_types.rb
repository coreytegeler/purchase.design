class DropResourceTypes < ActiveRecord::Migration[4.2]
  def change
  	drop_table 'resource_types'
  end
end
