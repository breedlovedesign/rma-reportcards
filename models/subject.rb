# encoding: utf-8
class Subject
  include Mongoid::Document
  field :subject_id
  field :name
  belongs_to :skill_tracking
end