class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
     t.time  :time
     t.integer :day
     t.integer :mentor_teacher_id #Foreign key
     t.timestamps
    end
  end
end
