class AddDashboardId < ActiveRecord::Migration
  def up
    add_column("dashboard_queries", "dashboard_id", "integer")
  end

  def down
  end
end
