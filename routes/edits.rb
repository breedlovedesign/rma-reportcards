get '/edits/teachers' do
  @title = "Peer Editing"
  if ["admin", "editor-in-chief"].include?(session[:role])
  	@teachers = Teacher.all
  elsif session[:role] == "teacher"
  	@teachers = Teacher.excludes(id: session[:teacher_id])
  end
  haml :"edits/teachers", :layout => :teacher_layout
end



get "/edits/:teacher_id" do
	teacher_id =  params[:teacher_id]
	@teacher  = Teacher.find_by(:id => params[:teacher_id])
	
	language_arts_students_skill_tracks  = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :language_arts_teacher  => teacher_id)
	math_students_skill_tracks           = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :math_teacher           => teacher_id)
	social_studies_students_skill_tracks = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :social_studies_teacher => teacher_id)
	science_students_skill_tracks        = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :science_teacher        => teacher_id)
	art_students_skill_tracks            = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :art_teacher            => teacher_id)
	ict_students_skill_tracks            = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :ict_teacher            => teacher_id)
	music_students_skill_tracks          = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :music_teacher          => teacher_id)
	thai_students_skill_tracks           = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :thai_teacher           => teacher_id)
	pe_students_skill_tracks             = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :pe_teacher             => teacher_id)
	work_study_students_skill_tracks     = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :work_study_teacher     => teacher_id)
	citizenship_students_skill_tracks    = SkillTrack.where(:grading_period => GradingPeriodPersist.all[0].grading_period.id.to_s, :citizenship_teacher    => teacher_id)


	begin
		language_arts_id = Subject.find_by(:subject_id => "language_arts").id.to_s
		language_arts_outcome_sets = language_arts_students_skill_tracks.collect { |skill_track| skill_track.outcome_sets.find_by(:subject_id => language_arts_id) }
		
		language_arts_students = []
		language_arts_outcome_sets.each do |set| 
			language_arts_component = {}
			language_arts_component[:skill_track] = set.skill_track
			language_arts_component[:language_arts_level] = set.skill_track.language_arts_level
			language_arts_component[:student_name] = Student.find("#{set.skill_track.student_id}").name
			language_arts_component[:student_id] = set.skill_track.student_id
			language_arts_component[:comment_object] = set.commentos 
			language_arts_component[:latest_comment] = set.commentos[-1]
		p "made it here"
			if set.commentos[-1].editor != nil
				language_arts_component[:editor] = Teacher.find(language_arts_component[:latest_comment].editor)
			end
		p "this did not happen"
		language_arts_students << language_arts_component
		end
		@language_arts = language_arts_students

		math_id = Subject.find_by(:subject_id => "math").id.to_s
		math_outcome_sets = math_students_skill_tracks.collect { |skill_track| skill_track.outcome_sets.find_by(:subject_id => math_id) }
		
		math_students = []
		math_outcome_sets.each do |set| 
			math_component = {}
			math_component[:skill_track] = set.skill_track
			math_component[:math_level] = set.skill_track.math_level
			math_component[:student_name] = Student.find("#{set.skill_track.student_id}").name
			math_component[:student_id] = set.skill_track.student_id
			math_component[:comment_object] = set.commentos 
			math_component[:latest_comment] = set.commentos[-1]
		
			if set.commentos[-1].editor != nil
				math_component[:editor] = Teacher.find(math_component[:latest_comment].editor)
				p "math set"
			else
				p "set.commentos[-1] == nil maybe"
			end
			
		math_students << math_component
		end
		@math = math_students
		haml :"edits/teacher_subjects", :layout => :teacher_layout
	rescue 
		pp params
		haml :"edits/fail", :layout => :teacher_layout	
	end
	
end
#/edit/submit/language_arts/#{Student.find_by(name: la[:student_name]).id}/#{la[:skill_track].id/#{@teacher.id}
post "/edit/submit/:subject_id/:student_id/:skill_track_id/:teacher_id" do
	form = params[:comment_form]

	student = Student.find_by(:id => params[:student_id])
	skill_track = student.skill_tracks.find_by(:id => params[:skill_track_id])

unless form["language_arts_comment"].nil?
	language_arts_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "language_arts"))
	#language_arts_outcome_set.commentos.create!(:texto => form["language_arts_comment"])
	raw_comment = form["language_arts_comment"]
	processed_comment = raw_comment.paragraph_prep
	doub = doublespacer(processed_comment)
	doub.paragraph_reinsertion
	language_arts_outcome_set.commentos.create!(:texto => doub, :editor => form["editor"])
	language_arts_outcome_set.save
end	

unless form["math_comment"].nil?
	math_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "math"))
	math_outcome_set.commentos.create!(:texto => form["math_comment"])
	math_outcome_set.save
end	

unless form["social_studies_comment"].nil?
	social_studies_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "social_studies"))
	social_studies_outcome_set.commentos.create!(:texto => form["social_studies_comment"])
	social_studies_outcome_set.save
end	

unless form["science_comment"].nil?
	science_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "science"))
	science_outcome_set.commentos.create!(:texto => form["science_comment"])
	science_outcome_set.save
end	

unless form["work_study_comment"].nil?
	work_study_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "work_study"))
	work_study_outcome_set.commentos.create!(:texto => form["work_study_comment"])
	work_study_outcome_set.save
end	

unless form["citizenship_comment"].nil?
	citizenship_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "citizenship"))
	citizenship_outcome_set.commentos.create!(:texto => form["citizenship_comment"])
	citizenship_outcome_set.save
end	

unless form["art_comment"].nil?
	art_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "art"))
	art_outcome_set.commentos.create!(:texto => form["art_comment"])
	art_outcome_set.save
end	

unless form["ict_comment"].nil?
	ict_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "ict"))
	ict_outcome_set.commentos.create!(:texto => form["ict_comment"])
	ict_outcome_set.save
end	

unless form["music_comment"].nil?
	music_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "music"))
	music_outcome_set.commentos.create!(:texto => form["music_comment"])
	music_outcome_set.save
end	

unless form["pe_comment"].nil?
	pe_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "pe"))
	pe_outcome_set.commentos.create!(:texto => form["pe_comment"])
	pe_outcome_set.save
end	

unless form["thai_comment"].nil?
	thai_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "thai"))
	thai_outcome_set.commentos.create!(:texto => form["thai_comment"])
	thai_outcome_set.save
end		

	redirect to("/edits/#{params[:teacher_id]}##{params[:subject_id]}_#{params[:student_id]}")
end