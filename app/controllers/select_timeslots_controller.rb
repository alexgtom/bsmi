class SelectTimeslotsController < ApplicationController
  include Wicked::Wizard
  steps :monday, :tuesday, :wednesday, :thursday, :friday, :rank, :summary
  
  def show
    @student = Student.find(params[:student_id])
    case step
    when :rank
      @preferences = @student.preferences
    end
    render_wizard 
  end

  def update
    student_id = params[:student_id]
    @student = Student.find(student_id)
    

    if step == :rank
      params[:pref].each do |k, v|
        p = Preference.find_by_id(k)
        p.ranking = v
        if not p.valid?
          if not flash[:error_list]
            flash[:error_list] = []
          end
          flash[:error_list].concat([p.errors.first[1]])
        end
        p.save
      end
      
      if flash[:error_list]
        redirect_to wizard_path
      else
        render_wizard @student
      end
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
