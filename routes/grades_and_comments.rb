# encoding: utf-8
get "/grading/:student_id" do
	teacher?
	@teacher = Teacher.find_by(:id => session[:teacher_id])
	@student = Student.find_by(:id => params[:student_id])
	@skill_track = @student.skill_tracks.find_by(:grading_period => $current_quarter)

	language_arts_id = Subject.find_by(:subject_id => "language_arts").id
	@language_arts_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => language_arts_id)

	math_id = Subject.find_by(:subject_id => "math").id
	@math_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => math_id)

	social_studies_id = Subject.find_by(:subject_id => "social_studies").id
	@social_studies_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => social_studies_id)

	science_id = Subject.find_by(:subject_id => "science").id
	@science_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => science_id)

	work_study_id = Subject.find_by(:subject_id => "work_study").id
	@work_study_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => work_study_id)

	citizenship_id = Subject.find_by(:subject_id => "citizenship").id
	@citizenship_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => citizenship_id)

	art_id = Subject.find_by(:subject_id => "art").id
	@art_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => art_id)

	ict_id = Subject.find_by(:subject_id => "ict").id
	@ict_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => ict_id)

	music_id = Subject.find_by(:subject_id => "music").id
	@music_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => music_id)

	pe_id = Subject.find_by(:subject_id => "pe").id
	@pe_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => pe_id)

	thai_id = Subject.find_by(:subject_id => "thai").id
	@thai_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => thai_id)
	

	haml :"grading/index", :layout => :teacher_layout
end

post "/grading/submit/:student_id/:skill_track_id" do
	form = params[:grades_comments_form]

	student = Student.find_by(:id => params[:student_id])
	skill_track = student.skill_tracks.find_by(:id => params[:skill_track_id])
	language_arts_outcome_set = skill_track.outcome_sets.find_by(:id => form["language_arts_outcome_set.id"])
	math_outcome_set = skill_track.outcome_sets.find_by(:id => form["math_outcome_set.id"])
	social_studies_outcome_set = skill_track.outcome_sets.find_by(:id => form["social_studies_outcome_set.id"])
	science_outcome_set = skill_track.outcome_sets.find_by(:id => form["science_outcome_set.id"])
	work_study_outcome_set = skill_track.outcome_sets.find_by(:id => form["work_study_outcome_set.id"])
	citizenship_outcome_set = skill_track.outcome_sets.find_by(:id => form["citizenship_outcome_set.id"])
	art_outcome_set = skill_track.outcome_sets.find_by(:id => form["art_outcome_set.id"])
	ict_outcome_set = skill_track.outcome_sets.find_by(:id => form["ict_outcome_set.id"])
	music_outcome_set = skill_track.outcome_sets.find_by(:id => form["music_outcome_set.id"])
	pe_outcome_set = skill_track.outcome_sets.find_by(:id => form["pe_outcome_set.id"])
	thai_outcome_set = skill_track.outcome_sets.find_by(:id => form["thai_outcome_set.id"])

	language_arts_outcome_set.update_attributes!(:comment => form["language_arts_comment"])
	language_arts_outcome_set.outcomes.each do |outcome|
		plus_minus = form["language_arts_plus_minus_#{outcome.indexo}"]
		grade      = form["language_arts_grade_#{outcome.indexo}"]     
		if plus_minus.nil?
			plus_minus = ""		
		end	
		if grade.nil?
			grade = ""
		end
		na_plus_blocker = "#{grade + plus_minus}"
		if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
			na_plus_blocker = "NA"
		end
		outcome.update_attributes!(:grade => na_plus_blocker)
	end
	

math_outcome_set.update_attributes!(:comment => form["math_comment"])
math_outcome_set.outcomes.each do |outcome|
	plus_minus = form["math_plus_minus_#{outcome.indexo}"]
	grade      = form["math_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


social_studies_outcome_set.update_attributes!(:comment => form["social_studies_comment"])
social_studies_outcome_set.outcomes.each do |outcome|
	plus_minus = form["social_studies_plus_minus_#{outcome.indexo}"]
	grade      = form["social_studies_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


science_outcome_set.update_attributes!(:comment => form["science_comment"])
science_outcome_set.outcomes.each do |outcome|
	plus_minus = form["science_plus_minus_#{outcome.indexo}"]
	grade      = form["science_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


work_study_outcome_set.update_attributes!(:comment => form["work_study_comment"])
work_study_outcome_set.outcomes.each do |outcome|
	plus_minus = form["work_study_plus_minus_#{outcome.indexo}"]
	grade      = form["work_study_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


citizenship_outcome_set.update_attributes!(:comment => form["citizenship_comment"])
citizenship_outcome_set.outcomes.each do |outcome|
	plus_minus = form["citizenship_plus_minus_#{outcome.indexo}"]
	grade      = form["citizenship_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


art_outcome_set.update_attributes!(:comment => form["art_comment"])
art_outcome_set.outcomes.each do |outcome|
	plus_minus = form["art_plus_minus_#{outcome.indexo}"]
	grade      = form["art_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


ict_outcome_set.update_attributes!(:comment => form["ict_comment"])
ict_outcome_set.outcomes.each do |outcome|
	plus_minus = form["ict_plus_minus_#{outcome.indexo}"]
	grade      = form["ict_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


music_outcome_set.update_attributes!(:comment => form["music_comment"])
music_outcome_set.outcomes.each do |outcome|
	plus_minus = form["music_plus_minus_#{outcome.indexo}"]
	grade      = form["music_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


pe_outcome_set.update_attributes!(:comment => form["pe_comment"])
pe_outcome_set.outcomes.each do |outcome|
	plus_minus = form["pe_plus_minus_#{outcome.indexo}"]
	grade      = form["pe_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end


thai_outcome_set.update_attributes!(:comment => form["thai_comment"])
thai_outcome_set.outcomes.each do |outcome|
	plus_minus = form["thai_plus_minus_#{outcome.indexo}"]
	grade      = form["thai_grade_#{outcome.indexo}"]     
	if plus_minus.nil?
		plus_minus = ""		
	end	
	if grade.nil?
		grade = ""
	end
	na_plus_blocker = "#{grade + plus_minus}"
	if (na_plus_blocker == "NA+") || (na_plus_blocker == "NA-")
		na_plus_blocker = "NA"
	end
	outcome.update_attributes!(:grade => na_plus_blocker)
end
	redirect to("/grading/#{params[:student_id]}")
end




































