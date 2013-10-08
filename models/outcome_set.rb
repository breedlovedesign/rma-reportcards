# encoding: utf-8
class OutcomeSet
  include Mongoid::Document
  field :level
  field :comment
  embeds_many :outcomes
  embedded_in :skill_track
  belongs_to :subject
  def count
    ls = self.outcomes
    ls.count
  end
end










