class RemoveLimitOnAboutText < ActiveRecord::Migration[4.2]
  def change
  	change_column :abouts, :text, :text, :limit => nil
  end
end
