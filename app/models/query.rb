class Query < ActiveRecord::Base

  attr_accessible :input, :output, :rows, :user_id, :updated_at
  belongs_to :user
  default_scope { order updated_at: :desc }
  validates_presence_of :user

end
