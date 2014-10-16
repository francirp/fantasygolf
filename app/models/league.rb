class League < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :normal_members, dependent: :destroy
  has_one :commissioner, dependent: :destroy
  accepts_nested_attributes_for :members
  accepts_nested_attributes_for :commissioner

end
