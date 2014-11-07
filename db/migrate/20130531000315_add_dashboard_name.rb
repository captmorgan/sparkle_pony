class AddDashboardName < ActiveRecord::Migration
  def up
    add_column("dashboards", "name", "string")

  end

  def down
  end
end
