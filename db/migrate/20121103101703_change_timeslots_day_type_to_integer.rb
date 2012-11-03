class ChangeTimeslotsDayTypeToInteger < ActiveRecord::Migration
  def up
    change_column :timeslots, :day, :integer
  end

  def down
    change_column :timeslots, :day, :string
  end
end
