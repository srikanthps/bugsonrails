class Member < ActiveRecord::Base

  def member_type
    if admin?
      "Administrator"
    else
      "User"
    end
  end

  def status
    active ? "active" : "inactive"
  end
end
