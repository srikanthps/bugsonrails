class BugMailer < ActionMailer::Base

  def status_email(bug, action_taken)
    emails = Member.all.map { |member| member.email }.compact
    
    if emails then
      recipients emails
      from "bugsonrails@github.com"
      subject "Bug #{bug.defect_id} #{action_taken} (#{bug.bug_status.description})"
      sent_on Time.now
      body :bug => bug
      content_type "text/html"
    end
  end

end
