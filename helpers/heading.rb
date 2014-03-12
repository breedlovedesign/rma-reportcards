# encoding: utf-8
module Heading
	def heading(text, heading_level)
		if heading_level == 1
			level_indicating_char = '='
		else
			level_indicating_char = '-'
		end
		text.to_s.length.times.collect { level_indicating_char }.join('')
	end

end
