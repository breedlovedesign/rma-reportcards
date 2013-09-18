class SkillTrack
  include Mongoid::Document
  field :language_arts_teacher
  field :math_teacher
  field :social_studies_teacher
  field :science_teacher
  field :art_teacher
  field :ict_teacher
  field :music_teacher
  field :thai_teacher
  field :pe_teacher
  field :work_study_teacher
  field :citizenship_teacher

  field :classroom_teacher
  field :student_level

  field :language_arts_level
  field :math_level
  field :social_studies_level
  field :science_level
  field :art_level
  field :ict_level
  field :music_level
  field :thai_level
  field :pe_level
  field :work_study_level
  field :citizenship_level
  
  field :eal_sss_status
  
  belongs_to :student
  has_one    :grading_period
end