# encoding: utf-8
class OutcomeSet
  include Mongoid::Document
  field :level
  belongs_to :subject
  embeds_many :outcomes
  def count
    ls = self.outcomes
    ls.count
  end
end










