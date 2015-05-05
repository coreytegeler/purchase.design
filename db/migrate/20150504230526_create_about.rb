class CreateAbout < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
    	t.string	'dept_title'
    	t.text		'dept_body'
    	t.string	'site_title'
    	t.text		'site_body'
    end
  end
end
