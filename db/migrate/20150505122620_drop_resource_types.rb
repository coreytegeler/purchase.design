class DropResourceTypes < ActiveRecord::Migration
  def change
  	drop_table 'resource_types'
  end
end
