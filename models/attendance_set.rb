# encoding: utf-8
class AttendanceSet
  include Mongoid::Document
  field :q1_tardy
  field :q1_absence
  field :q2_tardy
  field :q2_absence
  field :q3_tardy
  field :q3_absence
  field :q4_tardy
  field :q4_absence
  belongs_to :student
end



