class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
     t.time  :time
     t.integer :day
     t.timestamps
    end
  end
end
