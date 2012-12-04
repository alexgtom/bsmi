require 'spreadsheet'

class Student < ActiveRecord::Base  
  has_many :preferences
  has_many :mentor_teachers, :through => :placements
  has_and_belongs_to_many :semesters

  has_one :user, :as => :owner


  has_many :matchings
  has_many :placements, :through => :matchings, :uniq => true, :source => :timeslot

  accepts_nested_attributes_for :preferences
  has_and_belongs_to_many :cal_courses

  validate :cal_courses, :uniqueness => true
  validates_associated :preferences, :message => "must not be blank and the ranking number must be unique"

  def send_report
    Spreadsheet.client_encoding = 'UTF-8'
    report = Spreadsheet::Workbook.new
    writing_page = report.create_worksheet :name => "#{self.user.name} Student report"
    #Set up first Header
    writing_page[0,0] = 'Name'
    writing_page[0,3] = 'Date' 
    writing_page[1,0] = "#{self.user.name}"
    writing_page[1,3] = "#{Time.now.to_s}"
    #Set up table header for timeslots attended
    writing_page[3,0] = 'Semester'
    writing_page[3,1] = 'Cal Course'
    writing_page[3,2] = 'School' 
    writing_page[3,3] = 'Grade'
    writing_page[3,4] = 'Course'
    writing_page[3,5] = 'Mentor Teacher'
    writing_page[3,6] = 'Time'
    #Filling the table
    self.placements.each.with_index do |timeslot, i|
      writing_page[i+4, 0] = timeslot.semester.description if timeslot.semester
      writing_page[i+4, 1] = timeslot.cal_course.name if timeslot.cal_course
      entry = timeslot.build_entry(self.id)
      writing_page[i+4, 2] = entry["school_name"]
      if entry["course"]
        writing_page[i+4, 3] = entry["course"].grade
        writing_page[i+4, 4] = entry["course"].name
      end
      writing_page[i+4, 5] = entry["teacher"]
      writing_page[i+4, 6] = entry["time"]
    end
    #Adding header formats
    header_format = Spreadsheet::Format.new :weight => :bold,
                                            :size => 12
    writing_page.row(0).default_format = header_format
    writing_page.row(3).default_format = header_format
    #Adjust Spacing
    (0..6).each do |i|
      writing_page.column(i).width = 18
    end

    #Write File
    report.write "reports/report_#{self.user.id}_#{self.user.name}.xls"
    #send file here
  end

  def fix_ranking_gap
    # if a student has rankings [1, 2, 4] for their preferences, calling this function
    # will correct the rankings to [1, 2, 3]
    i = 1
    self.preferences.order("ranking asc").each do |p|
      logger.debug "#{i}"
      p.ranking = i
      p.save(:validate => false)
      i += 1
    end
  end

  def valid_preferences?(cal_course_id)
    preferences = self.preferences.all(:joins => :cal_course, :conditions => ["cal_course_id = ?", cal_course_id]) rescue -1
    preferences.size >= Setting['student_min_preferences'] and
    preferences.size <= Setting['student_max_preferences']
  end
end
