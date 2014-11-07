class RenameQueryidQuery < ActiveRecord::Migration
  def up
    rename_column("dashboard_queries", "query_id", "query")
    change_column("dashboard_queries", "query", "string")
          

  end

  def down
  end
end
