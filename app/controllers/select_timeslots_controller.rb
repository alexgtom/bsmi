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
      #delete_list = []
      #Preference.where(:student_id => student_id) do |p|
      #  if not p.timeslot.day == step
      #    delete_list << p
      #  end
      #end
      #Preference.destroy_all(delete_list)

      ## create or update new preferences
      #now = DateTime.now

      #if params[step]
      #  params[step].each do |timeslot_id|
      #    p = Preference.where(:student_id => student_id, :timeslot_id => timeslot_id).first || 
      #      Preference.new(:student_id => student_id, :timeslot_id => timeslot_id)
      #    p.updated_at = now
      #    p.save!

      #  end
      #end
      #render_wizard @student
      #
      Preference.transaction do 
        #Preference.joins(:timeslot)
        #    .where('timeslots.day' => Timeslot.day_index(step), :student_id => @student.id)
        #    .destroy_all
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

  def selected?(student_id)
    Preference.where(:student_id => student_id).where(:timeslot_id => id).size > 0
  end

end
