class DashboardQuery < ActiveRecord::Base
  attr_accessible :group, :query, :x_axis, :y_axis
  belongs_to :dashboard
  validates_presence_of :dashboard
end
