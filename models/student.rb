# encoding: utf-8
class Student
  include Mongoid::Document
  field :name
  field :nickname
  field :dob, type: Date
  has_many :skill_tracks
end