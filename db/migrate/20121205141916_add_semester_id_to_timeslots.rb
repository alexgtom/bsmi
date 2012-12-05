class AddSemesterIdToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :semester_id, :integer
  end
end
