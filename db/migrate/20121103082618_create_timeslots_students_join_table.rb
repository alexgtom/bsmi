class CreateTimeslotsStudentsJoinTable < ActiveRecord::Migration
  def up
    create_table :students_timeslots, :id => false do |t|
      t.integer :timeslot_id
      t.integer :student_id
    end
  end

  def down
    drop_table :students_timeslots
  end
end
