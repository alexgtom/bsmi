class SelectTimeslotsController < ApplicationController
  include Wicked::Wizard
  steps :monday, :tuesday, :wednesday, :thursday, :friday
  
  def show
    @student = Student.find(params[:student_id])
    render_wizard 
  end

  def update
    student_id = params[:student_id]
    @student = Student.find(student_id)

    # delte old preferences that were not selected again
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
