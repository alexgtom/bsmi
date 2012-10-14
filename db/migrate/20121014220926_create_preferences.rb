class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :student_id #Foreign key
      t.integer :timeslot_id #Foreign key
      t.integer :ranking
      t.timestamps
    end
  end
end
