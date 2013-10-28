# encoding: utf-8
class Commento
  include Mongoid::Document
  field :texto
  field :indexo, :type => Float
  field :time_stamp, :type => Time
  embedded_in :outcome_set
  def wordcount
    self.split.size
  end
  def charactercount
    self.count "a-z", "A-Z"
  end
end



