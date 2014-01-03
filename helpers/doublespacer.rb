# encoding: utf-8
module Doublespacer
	def doublespacer(comment)
		doubled = Lingua::EN::Sentence.sentences(comment).join("&nbsp; ")
		doubled
	end
end
