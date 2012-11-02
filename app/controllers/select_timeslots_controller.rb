class SelectTimeslotsController < ApplicationController
  include Wicked::Wizard
  steps :monday, :tuesday, :wednesday, :thursday, :friday, :rank, :summary
  
  def show
    @student = Student.find(params[:student_id])
    @timeslots = Timeslot.where(:day => Timeslot.day_index(step))

    case step
    when :rank
      @timeslots = Timeslot.find(@student.preferences.map{ |p| p.timeslot_id })
      @preferences = @student.preferences
    end

    case step
    when :summary
      @timeslots = Timeslot.find(@student.preferences.map{ |p| p.timeslot_id })
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

        logger.debug "current: #{current}"
        logger.debug "from_form: #{from_form}"
        logger.debug "intersection: #{intersection}"
        logger.debug "deleted: #{deleted}"

        deleted.each do |preference_id|
          #p = Preference.find(preference_id)
          #if p.ranking and p.ranking <= @student.preferences.size
          #  start_rank = p.ranking + 1
          #  [start_rank..@student.preferences.size].each do |new_rank|
          #    n = Preference.find(:student_id => @student.id, :ranking => new_rank)
          #    n.ranking = new_rank - 1
          #    n.save!
          #  end
          #end
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
