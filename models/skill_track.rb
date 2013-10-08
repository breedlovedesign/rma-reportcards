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

  def has_teacher teacher_id
    [self.language_arts_teacher, self.math_teacher, self.social_studies_teacher, self.science_teacher, self.art_teacher, self.ict_teacher, self.music_teacher, self.thai_teacher, self.pe_teacher, self.work_study_teacher, self.citizenship_teacher].include?(teacher_id)
  end

  def get_outcome_sets
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "language_arts").id, :level => self.language_arts_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "math").id, :level => self.math_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "social_studies").id, :level => self.social_studies_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "science").id, :level => self.science_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "art").id, :level => self.art_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "ict").id, :level => self.ict_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "music").id, :level => self.music_level).clone )
    if self.thai_native == "Non-Native" or self.thai_native == ""
      self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "thai").id, :level => self.thai_level).clone )
    else
      self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "thai").id, :level => "#{self.thai_level}-Native").clone )
    end
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "pe").id, :level => self.pe_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "work_study").id, :level => self.work_study_level).clone )
    self.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "citizenship").id, :level => self.citizenship_level).clone )
    self.save
  end
end
