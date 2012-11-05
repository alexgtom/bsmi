class RemoveUnnecessaryColumnsFromMentorTeacher < ActiveRecord::Migration
  def up
    remove_column :mentor_teachers, "mailing_address"
    remove_column :mentor_teachers, "phone_number"   
    remove_column :mentor_teachers, "email"          
    remove_column :mentor_teachers,  "password"       
  end
  def down                     
    add_column :mentor_teachers, "mailing_address", :string
    add_column :mentor_teachers, "phone_number", :string
    add_column :mentor_teachers, "email", :string          
    add_column :mentor_teachers,  "password", :string       
  end
end
