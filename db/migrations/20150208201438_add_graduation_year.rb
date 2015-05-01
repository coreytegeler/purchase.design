class AddGraduationYear < ActiveRecord::Migration
  def change
  	add_column('people', 'grad_year', :year)
  end
end
