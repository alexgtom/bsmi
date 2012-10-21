class SelectTimeslotsController < ApplicationController
  include Wicked::Wizard
  steps :monday, :tuesday, :wednesday, :thursday, :friday, :rank, :summary
  
  def show
    @student = Student.find(params[:student_id])
    @timeslots = Timeslot.where(:day => Timeslot.day_index(step))

    case step
    when :rank
      @preferences = @student.preferences
    end

    case step
    when :summary
      @preferences = @student.preferences.order("ranking ASC")
    end

    render_wizard 
  end

  def update
    student_id = params[:student_id]
    @student = Student.find(student_id)
    

    case step
    when :rank
      params[:student][:preferences_attributes].each_value do |v|
        p = Preference.find_by_id(v[:id])
        p.ranking = nil
        p.save!(:validate => false)
      end
      
      Student.transaction do 
        params[:student][:preferences_attributes].each_value do |v|
          p = @student.preferences.find_by_id(v[:id])
          p.ranking = v[:ranking]
          p.save
        end
      end

      render_wizard @student
    end

    case step
    when :monday, :tuesday, :wednesday, :thursday, :friday
      Preference.transaction do 
        Preference.where(:student_id => @student.id).each do |p|
          p.delete
        end

        params[step].each do |timeslot_id|
            Preference.create!(:student_id => @student.id, :timeslot_id => timeslot_id)
        end
      end
      render_wizard @student
    end  

  end
end
