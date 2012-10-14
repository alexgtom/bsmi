class CreateMentorteachers < ActiveRecord::Migration
  def change
    create_table :mentorteachers do |t|
      t.string :mailingaddress
      t.string :phonenumber
      t.string :email
      t.string :password
      t.string :school
      t.string :gradelevel
      t.string :classesteaching
      t.string :times

      t.timestamps
    end
  end
end
