class BugObserver < ActiveRecord::Observer
  def after_create(bug)
    #BugMailer.deliver_status_email(bug, 'Created') 
  end

  #def after_update(bug) 
  # BugMailer.deliver_status_email(bug, 'Updated')
  #end 

end