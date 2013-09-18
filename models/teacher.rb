class Teacher
  include Mongoid::Document
  field :name
  belongs_to :skill_tracking
end