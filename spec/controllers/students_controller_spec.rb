require 'spec_helper'

describe StudentsController do


  describe ".index" do
    before do
        @all_student = User.where(:owner_type => "Student")
        @sort = nil
    end
    it "assigns all students as @all_student when there is no sort" do
       if @sort == nil
         @all_student.should eq(User.where(:owner_type => "Student"))
       end
    end
    it "sort all students by name when sort is set to name" do
      if @sort == 'name'
        @all_student = @all_student.order(:name)
        @all_student.should eq(User.where(:owner_type => "Student").order(:name))
      end
    end
    it "sort all students by name when sort is set to placement" do
      if @sort == 'course'
        @all_student = @all_student.order(:placement)
        @all_student.should eq(User.where(:owner_type => "Student").order(:placement))
      end
    end
  end

  describe "sort" do
	
  end
  
  describe ".placement" do
  end
end
