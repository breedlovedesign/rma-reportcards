# encoding: utf-8
class Student
  include Mongoid::Document
  field :name
  field :nickname
  field :dob, type: Date
  has_many :skill_tracks
  has_one :attendance_set

  def bday
  	bday = "#{self.dob.strftime("%B %d, %Y")}"
  	bday
  end

  def embed_outcome_sets grading_period
  	
  end
end