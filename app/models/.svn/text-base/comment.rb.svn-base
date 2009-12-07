class Comment < ActiveRecord::Base
  belongs_to :bug
  belongs_to :commenter, :class_name => "Member", :foreign_key => "commenter_id"

  REVIEW = "Review"
  ADDITIONAL_REQUIREMENT = "Additional-Requirement"
  QA_FAILURE = "QA-Failure"
  DEVELOPER_NOTE = "Developer-Note"

  def review?
    REVIEW.eql?(comment_type)
  end

  def additional_requirement?
    ADDITIONAL_REQUIREMENT.eql?(comment_type)
  end

  def qa_failure?
    QA_FAILURE.eql?(comment_type)
  end

  def developer_note?
    DEVELOPER_NOTE.eql?(comment_type)
  end

end
