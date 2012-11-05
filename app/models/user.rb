class User < ActiveRecord::Base
  acts_as_authentic do |c|
  end # block optional

  @@user_types = Hash[[Advisor, MentorTeacher, Student].map {|type| [type.name, type]}]

  def self.user_types
    @@user_types
  end

  def self.build_owner(owner_type, options={})
    if not self.valid_user_type? owner_type
      throw ArgumentError.new("#{owner_type} is not a valid owner type for User")
    end

    @@user_types[owner_type].new(options)
  end

  #Return the valid user type options for a select button as a hash. Names are nicified.
  def self.user_types_for_select
    @@user_types.map{|k,v| [k.underscore.humanize, v]}
  end
  
  def self.valid_user_type?(type_name)
    @@user_types.include? type_name
  end

  belongs_to :owner, :polymorphic => true
  #Check that the polymorphic association specified is valid

  validates :owner_type, :inclusion => { :in => @@user_types}


end
