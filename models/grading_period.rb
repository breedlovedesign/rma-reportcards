# encoding: utf-8
class GradingPeriod
  include Mongoid::Document
  field :school_year   #2011–2012
  field :period_name   #Quarter 1
  field :signing_date, type: Date  #October 11, 2013
  has_many :skill_tracks
  belongs_to :grading_period_persist
  def gpname
    "#{self.school_year} – #{self.period_name} – #{self.signing_date.strftime("%B %e, %Y")}"
  end
  def name
    "#{self.school_year} – #{self.period_name}"
  end
  def year
    "#{self.period_name}  #{self.school_year}"
  end
end
