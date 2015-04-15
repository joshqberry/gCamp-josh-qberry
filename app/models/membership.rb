class Membership < ActiveRecord::Base

  validates :user_id, presence: true

  validates_uniqueness_of :user_id, :message => "has already been added to this project.", :scope => [:project_id]


  belongs_to :user
  belongs_to :project
end
