# encoding: utf-8
class Teacher
  include Mongoid::Document
  field :name
  has_many :skill_tracks
end