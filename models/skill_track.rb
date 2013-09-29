# encoding: utf-8
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
  
  field :student_level
  
  field :eal_sss_status
  field :thai_native
  
  embeds_many   :outcome_sets
  belongs_to :student
  belongs_to :grading_period
  belongs_to :teacher # homeroom teacher, aka classroom teacher
end


