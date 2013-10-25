# encoding: utf-8
class OutcomeSet
  include Mongoid::Document
  field :level
  embeds_many :outcomes
  embeds_many :commentos
  embedded_in :skill_track
  field :comment
  def count
    ls = self.outcomes
    ls.count
  end
end
