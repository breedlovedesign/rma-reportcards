# encoding: utf-8
class Outcome
  include Mongoid::Document
  field :texto
  field :indexo, :type => Float
  field :grade
  embedded_in :outcome_set
  def wordcount
    self.split.size
  end
  def charactercount
    self.count "a-z", "A-Z"
  end
end



