class Status < ActiveRecord::Base
  has_many :bugs

  def self.find_by_user_role (admin)
    if admin then
      all
    else
      find_all_by_admin_only false
    end
  end
end
