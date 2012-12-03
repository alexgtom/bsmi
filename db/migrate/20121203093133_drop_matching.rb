class DropMatching < ActiveRecord::Migration
  def up
    drop_table :matchings
  end

  def down
    create_table :matchings do |t|
      t.integer :student_id
      t.integer :timeslot_id
      t.integer :ranking
      t.timestamps
    end
  end
end
