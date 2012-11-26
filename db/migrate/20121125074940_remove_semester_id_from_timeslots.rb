class RemoveSemesterIdFromTimeslots < ActiveRecord::Migration
  def up
    remove_column :timeslots, :semester_id
  end

  def down
    add_column :timeslots, :semester_id, :integer
  end
end
