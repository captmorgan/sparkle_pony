class CreateDashboardQueries < ActiveRecord::Migration
  def change
    create_table :dashboard_queries do |t|
      t.integer :query_id
      t.string :group
      t.string :x_axis
      t.string :y_axis

      t.timestamps
    end
  end
end
