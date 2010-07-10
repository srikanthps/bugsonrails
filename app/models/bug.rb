class Bug < ActiveRecord::Base
  belongs_to :developer, :class_name => "Member"
  belongs_to :reviewer, :class_name => "Member"
  belongs_to :release
  has_many :comments
  belongs_to :bug_status, :class_name => "Status" , :foreign_key => "status_id"
  validates_presence_of :defect_id, :bug_status
  validates_presence_of :release, :on=>:update
  
  validate :reviewed_for_correctness
  validate :reviewer_cant_be_empty_if_reviewed

  def reviewed_for_correctness
    errors.add_to_base("Specify whether bug is reviewed and who is the reviewer to set this status.") if (bug_status and bug_status.category == "done" and not reviewed?)
  end

  def reviewer_cant_be_empty_if_reviewed
    errors.add_to_base("Must specify reviewer if bug is reviewed") if (reviewed? and reviewer.nil?)
  end

  def defect?
    "Defect".eql?(defect_type)
  end

end
