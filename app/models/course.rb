class Course < ActiveRecord::Base
  belongs_to :venue
  has_many :holes
end
