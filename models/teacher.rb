# encoding: utf-8
class Teacher
  include Mongoid::Document
  field :name
  field :password
  has_many :skill_tracks
end