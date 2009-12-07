class CreateBugs < ActiveRecord::Migration
  def self.up
    create_table :bugs do |t|
      t.integer :defect_id
      t.string :defect_type
      t.string :priority
      t.text :summary
      t.string :developer
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :bugs
  end
end
