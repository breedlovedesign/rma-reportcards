# encoding: utf-8
class Commento
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  # comment.c_at #=> time object, format with
  # .stamp(Jan 1, 1999) (stamp gem adds method to Time) 
  # and or .to_pretty (PrettyDate module)
  field :texto
  field :indexo, :type => Float
  field :author, :default => ""
  field :editor, :default => ""
  field :eic, :default => ""
  field :author_approval, :type => Boolean, :default => false
  field :eic_approval, :type => Boolean, :default => false
  embedded_in :outcome_set
  def wordcount
    self.split.size
  end
  def charactercount
    self.count "a-z", "A-Z"
  end
end