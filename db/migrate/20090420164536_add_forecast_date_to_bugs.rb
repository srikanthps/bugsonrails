class AddForecastDateToBugs < ActiveRecord::Migration
  def self.up
    add_column :bugs, :estimate, :string
    add_column :bugs, :planned_completion_date, :date
  end

  def self.down
    remove_column :bugs, :estimate, :string
    remove_column :bugs, :planned_completion_date, :date
  end
end
