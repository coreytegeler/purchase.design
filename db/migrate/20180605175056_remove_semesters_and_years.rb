class RemoveSemestersAndYears < ActiveRecord::Migration[5.2]
  def change
  	drop_table 'semesters'
  	drop_table 'years'
  end
end
