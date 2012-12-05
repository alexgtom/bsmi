class SelectTimeslotsController < ApplicationController
  include Wicked::Wizard
  steps :monday, :tuesday, :wednesday, :thursday, :friday, :rank, :summary
  
  def show
    if Semester::past_deadline?
      flash[:notice] = "The deadline for registration has already passed. You can no longer modify your timeslot preferenes."
    end
    @cal_course = CalCourse.find(params[:cal_course_id])
    @student = Student.find(params[:student_id])
    @timeslots = Timeslot.find_by_semester_id(semester).where(:day => Timeslot.day_index(step), :cal_course_id => params[:cal_course_id])
  
    case step
    when :rank, :summary
      if @student.preferences.size < Setting['student_min_preferences'] or
        @student.preferences.size > Setting['student_max_preferences']
        flash[:error] = "You must select #{Setting['student_min_preferences']}-#{Setting['student_max_preferences']} timeslots."
        render :action => "error"
        return
      end
    end

    case step
    when :rank
      begin
        @timeslots = Timeslot.find_by_semester_id(semester).find(@student.preferences.map{ |p| p.timeslot_id })
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Error: Cannot rank until timeslots have been selected"
        render :action => "error"
        return
      end
      @preferences = @student.preferences
    end

    case step
    when :summary
      begin
        @timeslots = Timeslot.find_by_semester_id(semester).find(@student.preferences.map{ |p| p.timeslot_id })
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Error: Cannot view summary until timeslots have been selected"
        render :action => "error"
        return
      end
      @preferences = @student.preferences.order("ranking ASC")
    end

    render_wizard 
  end

  def update
    if Semester::past_deadline?
      return
    end

    @cal_course = CalCourse.find(params[:cal_course_id])
    @student = Student.find(params[:student_id])

    case step
    when :friday, :rank, :summary
      if @student.preferences.size < Setting['student_min_preferences'] or
        @student.preferences.size > Setting['student_max_preferences']
        flash[:error] = "You must select #{Setting['student_min_preferences']}-#{Setting['student_max_preferences']} timeslots."

        if step == :friday
          redirect_to wizard_path(:friday)
        else
          redirect_to wizard_path(:monday)
        end
        return
      end
    end

    case step
    when :cal_course_selection
      params[:student][:cal_courses].each_value do |v|
        CalCourse.find(v) << @student
      end

    end

    case step
    when :rank
      valid = true
      Preference.transaction do 
        params[:student][:preferences_attributes].each_value do |v|
          p = Preference.find_by_id(v[:id])
          p.ranking = nil
          p.save!(:validate => false)
        end
        
        params[:student][:preferences_attributes].each_value do |v|
          p = Preference.find_by_id(v[:id])
          p.ranking = v[:ranking]
          if not p.valid?
            valid = false
            flash[:error] = "The ranking for preference must be unique."
            raise ActiveRecord::Rollback
          end
          p.save
        end
      end
      
      if valid
        render_wizard @student
      else
        redirect_to wizard_path
      end
    end

    case step
    when :monday, :tuesday, :wednesday, :thursday, :friday
        current = []
        from_form = []

        Preference.where(:student_id => @student.id).each do |p|
          if p.timeslot.day == step
            current << p.id
          end
        end
        
        if params[step]
          params[step].each do |timeslot_id|
            p = Preference.find_by_student_id_and_timeslot_id(@student.id, timeslot_id)
            if not p
              p = Preference.create(:student_id => @student.id, :timeslot_id => timeslot_id)
            end
            from_form << p.id
          end
        end

        intersection = current & from_form
        deleted = current - intersection

        deleted.each do |preference_id|
          Preference.delete(preference_id)
        end

        @student.fix_ranking_gap

      if params[:commit] == 'Save'
        redirect_to wizard_path
      elsif params[:commit] == 'Save & Continue'
        render_wizard @student
      end
    end  
  end

end
