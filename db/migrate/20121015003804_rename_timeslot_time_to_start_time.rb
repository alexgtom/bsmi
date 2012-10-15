class RenameTimeslotTimeToStartTime < ActiveRecord::Migration
  def up
    rename_column :timeslots, :time, :start_time
    add_column :timeslots, :end_time, :time
  end

  def down
    rename_column :timeslots, :start_time, :time
    drop_column :timeslots, :end_time
  end
end
