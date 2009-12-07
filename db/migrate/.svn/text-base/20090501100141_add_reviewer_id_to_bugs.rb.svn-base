class AddReviewerIdToBugs < ActiveRecord::Migration
  def self.up
    add_column :bugs, :reviewer_id, :integer
  end

  def self.down
    remove_column :bugs, :reviewer_id
  end
end
