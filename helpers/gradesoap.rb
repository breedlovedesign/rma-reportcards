# encoding: utf-8
module Gradesoap
	def gradesoap( grade )

		if grade == "" || grade.nil?
			return false
		end
		grade.strip!
		grade.upcase!
		good_grades = [ "A", "B", "C", "D", "E", "A-", "B-", "C-", "D-", "A+", "B+", "C+", "D+", "NA" ]
		backwards_grades = [ "-A", "-B", "-C", "-D", "+A", "+B", "+C", "+D"]
		if good_grades.include?(grade)
			grade
		elsif backwards_grades.include?(grade)
			letter = grade[1]
			plus_minus = grade[0]
			grade = letter + plus_minus
			grade
		else
			grade = ""
		end
	end

end
