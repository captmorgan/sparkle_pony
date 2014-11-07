class User < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: true
  has_many :queries
  has_many :dashboards
  has_many :reports
end
