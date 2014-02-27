SUBJECTS = [:language_arts, :math, :social_studies, :science, :art, :ict, :music, :thai, :pe, :work_study, :citizenship]
TEACHERS = [:language_arts_teacher, :math_teacher, :social_studies_teacher, :science_teacher, :art_teacher, :ict_teacher, :music_teacher, :thai_teacher, :pe_teacher, :work_study_teacher, :citizenship_teacher]
quarter_id = GradingPeriod.find("529585627e225cb493000002").id.to_s

brendan = Student.find_by(:name => "Brendan Dempsey")
brendan_id = brendan.id.to_s

def poll(stu)
	p stu.name
end

# Student.all.each do |stu|
# 	p stu.skill_tracks.find_by(:grading_period_id => quarter_id).language_arts_teacher # returns id of la teacher
# end; nil



# Student.all.each do |student|
# 	output = []
# 	TEACHERS.each do |sub|
# 		var = student.skill_tracks.find_by(:grading_period_id => quarter_id).method(sub)
# 		teacher_id = var.call
# 		output << [sub.to_s, Teacher.find(teacher_id).name]
# 	end; nil

# 	p output
# end; nil

#per subject
#  per student
#    student name, teacher name, level
TEACHERS.each do |subject|
	p subject.to_s + "---------------------------------------"
	Student.all.each do |student| 
		skill_track = student.skill_tracks.find_by(:grading_period_id => quarter_id)
		subject_method = skill_track.method(subject)
		teacher_id = subject_method.call
		
		lev = (subject.to_s.sub(/teacher/, "level")).to_sym
		level_method = skill_track.method(lev)
		p "#{student.name},#{Teacher.find(teacher_id).name},#{level_method.call}"
	end
end; nil
#
# student_level:
# eal_sss_status:
# thai_native:
# teacher_id: 
thing = :student_level
	p :student_level.to_s + "---------------------------------------"
	Student.all.each do |student| 
		skill_track = student.skill_tracks.find_by(:grading_period_id => quarter_id)
		subject_method = skill_track.method(:student_level)
		#teacher_id = subject_method.call
		
		#lev = (subject.to_s.sub(/teacher/, "level")).to_sym
		#level_method = skill_track.method(lev)
		p "#{student.name},#{subject_method.call}"
	end;nil


	thing = :teacher_id
		p "classroom_teacher" + "---------------------------------------"
		Student.all.each do |student| 
			skill_track = student.skill_tracks.find_by(:grading_period_id => quarter_id)
			subject_method = skill_track.method(:teacher_id)
			teacher_id = subject_method.call
			
			#lev = (subject.to_s.sub(/teacher/, "level")).to_sym
			#level_method = skill_track.method(lev)
			p "#{student.name},#{Teacher.find(teacher_id).name}"
		end;nil