class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :employee_id
      t.string :name
      t.string :contact_number
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
