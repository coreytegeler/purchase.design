class RemoveLimitOnAboutText < ActiveRecord::Migration
  def change
  	change_column :abouts, :text, :text, :limit => nil
  end
end
