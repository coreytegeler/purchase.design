class AddMediaTypeToWorks < ActiveRecord::Migration
  def change
  	add_column 'works', 'media_types', :string
  end
end
