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
    

    if step == :rank
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
    else
      # delete old preferences that were not selected again
      delete_list = []
      Preference.where(:student_id => student_id) do |p|
        if not p.timeslot.day == step
          delete_list
        end
      end
      Preference.destroy_all(delete_list)

      # create or update new preferences
      now = DateTime.now

      if params[step]
        params[step].each do |timeslot_id|
          p = Preference.where(:student_id => student_id, :id => timeslot_id).first || Preference.new()
          p = p.update_attributes(
            :student_id => student_id,
            :timeslot_id => timeslot_id,
            :updated_at => now,
          )

        end
      end
      render_wizard @student
    end  

  end

end
