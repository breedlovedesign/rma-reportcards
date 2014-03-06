# encoding: utf-8
class GradingPeriodPersist
  include Mongoid::Document
  has_one :grading_period
end
