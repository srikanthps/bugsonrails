class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :code
      t.string :description
      t.string :category
      t.boolean :admin_only, :default => false

      t.timestamps
    end

    [
      {:code => "yet_to_start", :category => "to_do", :description => "Yet to start"},
      {:code => "pending_clarification", :category => "to_clarify", :description => "Pending clarification"},
      {:code => "working_on_it", :category => "in_progress", :description => "Working on it"},
      {:code => "code_review", :category => "to_verify", :description => "Code review, please!"},
      {:code => "does_not_seem_like_issue", :category => "to_verify", :description => "Not a issue"},
      {:code => "ready_for_build", :category => "done", :description => "Ready for build"},
      {:code => "verified_not_an_issue", :category => "done", :description => "Verified - Not a issue",  :admin_only => true},
      {:code => "closed_as_not_issue", :category => "done", :description => "Closed as not an issue", :admin_only => true},
      {:code => "considered_already_fixed", :category => "done", :description => "Considered already fixed", :admin_only => true},
      {:code => "done", :category => "done", :description => "Done", :admin_only => true}
    ].each do |status_data|
      status = Status.new (status_data)
      status.save
    end
  end

  def self.down
    drop_table :statuses
  end
end
