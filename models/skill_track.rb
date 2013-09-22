class SkillTrack
  include Mongoid::Document


  
  belongs_to :student
  belongs_to :grading_period
  belongs_to :teacher
end


