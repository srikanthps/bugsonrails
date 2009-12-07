class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :release_number
      t.datetime :release_date
      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
