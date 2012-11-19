class CreateMatching < ActiveRecord::Migration
  def up
    create_table :matchings do |t|
      t.integer :student_id
      t.integer :timeslot_id
 
      t.timestamps
    end
  end

  def down
    drop_table :matchings
  end
end
