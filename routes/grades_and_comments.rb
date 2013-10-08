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


	language_arts_outcome_set.update_attributes!(:comment => form["language_arts_comment"])
	redirect to("/grading/#{params[:student_id]}")
end
