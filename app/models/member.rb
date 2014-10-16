class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  def full_name
    user.full_name
  end

end
