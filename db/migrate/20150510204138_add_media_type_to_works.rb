class AddMediaTypeToWorks < ActiveRecord::Migration[4.2]
  def change
  	add_column 'works', 'media_types', :string
  end
end
