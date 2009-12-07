class AddStatusIdToBugs < ActiveRecord::Migration
  def self.up
    add_column :bugs, :status_id, :integer

    Bug.reset_column_information
    Bug.all.each do |bug|
      status = Status.find_by_description(bug.status)
      if (status) then
        bug.status_id = status.id
        bug.save
      end
    end
  end

  def self.down
    remove_column :bugs, :status_id
  end
end
