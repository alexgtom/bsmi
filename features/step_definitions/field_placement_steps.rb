Given /the following courses exist/ do |tb|
  tb.hashes.each do |t|
    Course.create!(t)
  end
end


Given /the following districts exist/ do |tb|
  tb.hashes.each do |t|
  	District.create!(t)
  end
end

Given /the following schools exist/ do |tb|
  tb.hashes.each do |t|
    t['district'] = District.find_by_name(t['district'])
  	School.create!(t)
  end
end

Given /the following mentor teachers exist/ do |tb|
  tb.hashes.each do |t|
    user = User.new({
      :first_name => t['first_name'],
      :last_name => t['last_name'],
      :address => t['address'],
      :phone_number => t['phone_number'],
      :email => t['email'],
      :password => '1234',
      :password_confirmation => '1234'
    })
    owner = User.build_owner("MentorTeacher")
    owner.school = School.find_by_name!(t['school'])
    owner.save!
    user.owner = owner
    user.save!
  end
end

Given /the following assignments exist/ do |tb|
  tb.hashes.each do |t|
    student = Student.find(t['user_id'])
    student.placements << Timeslot.find(t['timeslot_id'])
    student.save!
  end
end

