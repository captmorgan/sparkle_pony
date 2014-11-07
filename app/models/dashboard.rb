class Dashboard < ActiveRecord::Base
  attr_accessible :user_id, :name
  has_many :dashboard_queries, :dependent => :destroy
  belongs_to :user
end
