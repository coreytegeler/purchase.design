class CreatePersonEdits < ActiveRecord::Migration
  def up
    create_table :person_edits do |t|
      t.references :admin
      t.references :person
      t.string :summary
      t.timestamps null: false
    end
    add_index :person_edits, ["admin_id", "person_id"]
  end

  def down 
  	drop_table :person_edits
  end
end
