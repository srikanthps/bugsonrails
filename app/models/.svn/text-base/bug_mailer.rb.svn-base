class BugMailer < ActionMailer::Base

  def status_email(bug, action_taken)
    recipients ["SITA_WorldTracerWeb@mindtree.com"]  #SITA_WorldTracerWeb
    from "RoR_Bug_Manager@mindtree.com"
    subject "Bug #{bug.defect_id} #{action_taken} (#{bug.status})"
    sent_on Time.now
    body :bug => bug
    content_type "text/html"
  end

end
