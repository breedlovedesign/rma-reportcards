# encoding: utf-8
class AttendanceSet
  include Mongoid::Document
  field :q1_tardy,    default: "-"
  field :q1_absence,  default: "-"
  field :q1_days,     default: "-"
  field :q2_tardy,    default: "-"
  field :q2_absence,  default: "-"
  field :q2_days,     default: "-"
  field :q3_tardy,    default: "-"
  field :q3_absence,  default: "-"
  field :q3_days,     default: "-"
  field :q4_tardy,    default: "-"
  field :q4_absence,  default: "-"
  field :q4_days,     default: "-"
  belongs_to :student
end



