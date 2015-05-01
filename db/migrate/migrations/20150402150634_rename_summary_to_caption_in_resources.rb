class RenameSummaryToCaptionInResources < ActiveRecord::Migration
  def change
  	add_column "resources", "type_id", "integer"
  end
end
