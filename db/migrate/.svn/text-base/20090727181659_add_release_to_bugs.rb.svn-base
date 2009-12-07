class AddReleaseToBugs < ActiveRecord::Migration
  def self.up
    change_table :bugs do |t|
      t.references :release
    end
  end

  def self.down
    change_table :bugs do |t|
      t.remove_references :release
    end
  end
end
