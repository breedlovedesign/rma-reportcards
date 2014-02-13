get '/edits/teachers' do
  @title = "Peer Editing"	
  @teachers = Teacher.all
  haml :"edits/teachers", :layout => :teacher_layout
end



get "/edits/:teacher_id" do
	teacher_id =  params[:teacher_id]
	@teacher  = Teacher.find_by(:id => params[:teacher_id])
	
	language_arts_students_skill_tracks  = SkillTrack.where(:grading_period => $current_quarter, :language_arts_teacher  => teacher_id)
	math_students_skill_tracks           = SkillTrack.where(:grading_period => $current_quarter, :math_teacher           => teacher_id)
	social_studies_students_skill_tracks = SkillTrack.where(:grading_period => $current_quarter, :social_studies_teacher => teacher_id)
	science_students_skill_tracks        = SkillTrack.where(:grading_period => $current_quarter, :science_teacher        => teacher_id)
	art_students_skill_tracks            = SkillTrack.where(:grading_period => $current_quarter, :art_teacher            => teacher_id)
	ict_students_skill_tracks            = SkillTrack.where(:grading_period => $current_quarter, :ict_teacher            => teacher_id)
	music_students_skill_tracks          = SkillTrack.where(:grading_period => $current_quarter, :music_teacher          => teacher_id)
	thai_students_skill_tracks           = SkillTrack.where(:grading_period => $current_quarter, :thai_teacher           => teacher_id)
	pe_students_skill_tracks             = SkillTrack.where(:grading_period => $current_quarter, :pe_teacher             => teacher_id)
	work_study_students_skill_tracks     = SkillTrack.where(:grading_period => $current_quarter, :work_study_teacher     => teacher_id)
	citizenship_students_skill_tracks    = SkillTrack.where(:grading_period => $current_quarter, :citizenship_teacher    => teacher_id)


	language_arts_id = Subject.find_by(:subject_id => "language_arts").id.to_s
	language_arts_outcome_sets = language_arts_students_skill_tracks.collect { |skill_track| skill_track.outcome_sets.find_by(:subject_id => language_arts_id) }
	
	language_arts_students = []
	language_arts_outcome_sets.each do |set| 
		language_arts_component = {}
		language_arts_component[:student_name] = Student.find("#{set.skill_track.student_id}").name
		language_arts_component[:comment_object] = set.commentos 
		language_arts_students << language_arts_component
	end
@language_arts = language_arts_students

	haml :"edits/teacher_subjects", :layout => :teacher_layout
end

# language_arts_teacher
# math_teacher
# social_studies_teacher
# science_teacher
# art_teacher
# ict_teacher
# music_teacher
# thai_teacher
# pe_teacher
# work_study_teacher
# citizenship_teacher

# get "/edits/:teacher_id" do
# 	@teacher  = Teacher.find_by(:id => params[:teacher_id])
# 	@students = Student.all.map do |student|
# 		if student.current_skill_track.has_teacher(@teacher.id.to_s)
# 			student # build a list in @students of this teacher's students
# 		end
# 	end
# 	@students.compact!
# 	@subjects = @students.map do |student|
# 		student.current_skill_track.which_subjects(@teacher.id.to_s)
# 	end
# 	@subjects = @subjects.flatten.uniq
# 	haml :"edits/teacher_subjects", :layout => :teacher_layout
# end