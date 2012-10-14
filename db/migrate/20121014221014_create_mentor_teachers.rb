class CreateMentorTeachers < ActiveRecord::Migration
  def change
    create_table :mentor_teachers do |t|
      t.string :mailingaddress
      t.string :phonenumber
      t.string :email
      t.string :password
      t.string :school
      t.string :gradelevel
      t.string :classesteaching
      t.timestamps
    end
  end
end
