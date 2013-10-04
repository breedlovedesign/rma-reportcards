# encoding: utf-8
class Subject
  include Mongoid::Document
  field :subject_id
  field :name
  has_many :outcome_sets
end