class User < ActiveRecord::Base
  acts_as_authentic do |c|
  end # block optional

  belongs_to :owner, :polymorphic => true
end
