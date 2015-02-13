class AddSlugs < ActiveRecord::Migration
  def up
  	rename_column("groups", "permalink", "slug")
  	rename_column("posts", "permalink", "slug")
  	rename_column("people", "permalink", "slug")
  	add_column("works", "slug" ,:string)
  end

  def down 
  	drop_column("works", "slug")
  	rename_column("people", "slug", "permalink")
  	rename_column("posts", "slug", "permalink")
  	rename_column("groups", "slug", "permalink")
  end
end
