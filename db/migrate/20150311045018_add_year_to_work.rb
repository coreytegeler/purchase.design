class AddYearToWork < ActiveRecord::Migration
  def change
  		add_column("works", "year", :datetime)
  end
end
