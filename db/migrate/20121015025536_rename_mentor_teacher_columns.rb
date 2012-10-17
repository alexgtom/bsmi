class RenameMentorTeacherColumns < ActiveRecord::Migration
  #Rename mentor teacher columns to follow a more sane naming convention
  def up
    rename_column :mentor_teachers, :mailingaddress, :mailing_address
    rename_column :mentor_teachers, :phonenumber, :phone_number
  end

  def down
    rename_column :mentor_teachers, :mailing_address, :mailingaddress
    rename_column :mentor_teachers, :phone_number, :phonenumber
  end
end
