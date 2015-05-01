class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|

      t.timestamps null: false
    end
  end
end
