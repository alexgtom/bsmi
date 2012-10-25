class User < ActiveRecord::Base
  acts_as_authentic do |c|
  end # block optional

  @@user_types = Hash[[MentorTeacher, Student].map {|type| [type.name, type]}]
  def self.names_to_user_types
    @@user_types
  end


  
  def self.valid_user_type?(type_name)
    self.names_to_user_types.include? type_name
  end

  def self.user_type_names
    @@user_types.keys
  end

  # def self.user_type_nice_names
  #   @@user_types.keys.map{|n| n.underscore.humanize}
  # end


  belongs_to :owner, :polymorphic => true
  #Check that the polymorphic association specified is valid

  validates :owner_type, :inclusion => { :in => user_type_names}
#  validates :owner, :only_polymorphic => true
end
