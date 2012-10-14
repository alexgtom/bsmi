class CreateMentorTeachers < ActiveRecord::Migration
  def change
    create_table :mentor_teachers do |t|

      t.timestamps
    end
  end
end
