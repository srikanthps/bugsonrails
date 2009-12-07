class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :commenter_id
      t.string :status
      t.integer :bug_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
