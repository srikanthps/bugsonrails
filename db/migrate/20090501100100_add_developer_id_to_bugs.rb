class AddDeveloperIdToBugs < ActiveRecord::Migration
 
  def self.up
    add_column :bugs, :developer_id, :integer
  end

  def self.down
    remove_column :bugs, :developer_id
  end

end
