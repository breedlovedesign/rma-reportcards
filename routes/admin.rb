# encoding: utf-8
get "/admin" do
	admin?
	@title = "Admin Panel"	
	@quarters = GradingPeriod.all
	haml :"admin/index"
end

post "/admin/go" do
	admin?
	p = params[:admin_form]
	$message = p["message"] unless p["message"] == ""
	
	GradingPeriodPersist.all[0].grading_period = GradingPeriod.find("#{p["current_quarter"]}")
	redirect to('/admin')
end

get "/admin/comment_status" do
	admin?
	@title = "Comment Status"	
	#@pdfs = urls for the pdfs
	haml :"admin/comment_status"
end

get "/admin/create_comment_hardcopy" do
	admin?
	gpp = GradingPeriodPersist.all[0] # grading period persistance object
	gp_id = gpp.grading_period.id.to_s # id string for current grading period
	skill_tracks = []
	SkillTrack.where(grading_period: gp_id).each {|skt| skill_tracks << skt}

	data = []
	skill_tracks.each do |skt|
	  language_arts_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "language_arts").id)
	  if language_arts_set.commentos[-1] == nil
	    language_arts_comment = ""
	    missing = true 
	  else
	    language_arts_comment =  language_arts_set.commentos[-1].texto 
	    missing = false
	  end 
	  language_arts_teacher = Teacher.find(skt.language_arts_teacher).name
	  language_arts_level = skt.language_arts_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :language_arts, :comment => language_arts_comment, :teacher => language_arts_teacher, :level => language_arts_level}


	  math_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "math").id)
	  if math_set.commentos[-1] == nil
	    math_comment = ""
	    missing = true 
	  else
	    math_comment =  math_set.commentos[-1].texto 
	    missing = false
	  end 
	  math_teacher = Teacher.find(skt.math_teacher).name
	  math_level = skt.math_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :math, :comment => math_comment, :teacher => math_teacher, :level => math_level}


	  social_studies_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "social_studies").id)
	  if social_studies_set.commentos[-1] == nil
	    social_studies_comment = ""
	    missing = true 
	  else
	    social_studies_comment =  social_studies_set.commentos[-1].texto 
	    missing = false
	  end 
	  social_studies_teacher = Teacher.find(skt.social_studies_teacher).name
	  social_studies_level = skt.social_studies_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :social_studies, :comment => social_studies_comment, :teacher => social_studies_teacher, :level => social_studies_level}


	  science_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "science").id)
	  if science_set.commentos[-1] == nil
	    science_comment = ""
	    missing = true 
	  else
	    science_comment =  science_set.commentos[-1].texto 
	    missing = false
	  end 
	  science_teacher = Teacher.find(skt.science_teacher).name
	  science_level = skt.science_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :science, :comment => science_comment, :teacher => science_teacher, :level => science_level}


	  work_study_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "work_study").id)
	  if work_study_set.commentos[-1] == nil
	    work_study_comment = ""
	    missing = true 
	  else
	    work_study_comment =  work_study_set.commentos[-1].texto 
	    missing = false
	  end 
	  work_study_teacher = Teacher.find(skt.work_study_teacher).name
	  work_study_level = skt.work_study_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :work_study, :comment => work_study_comment, :teacher => work_study_teacher, :level => work_study_level}


	  citizenship_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "citizenship").id)
	  if citizenship_set.commentos[-1] == nil
	    citizenship_comment = ""
	    missing = true 
	  else
	    citizenship_comment =  citizenship_set.commentos[-1].texto 
	    missing = false
	  end 
	  citizenship_teacher = Teacher.find(skt.citizenship_teacher).name
	  citizenship_level = skt.citizenship_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :citizenship, :comment => citizenship_comment, :teacher => citizenship_teacher, :level => citizenship_level}


	  art_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "art").id)
	  if art_set.commentos[-1] == nil
	    art_comment = ""
	    missing = true 
	  else
	    art_comment =  art_set.commentos[-1].texto 
	    missing = false
	  end 
	  art_teacher = Teacher.find(skt.art_teacher).name
	  art_level = skt.art_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :art, :comment => art_comment, :teacher => art_teacher, :level => art_level}


	  ict_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "ict").id)
	  if ict_set.commentos[-1] == nil
	    ict_comment = ""
	    missing = true 
	  else
	    ict_comment =  ict_set.commentos[-1].texto 
	    missing = false
	  end 
	  ict_teacher = Teacher.find(skt.ict_teacher).name
	  ict_level = skt.ict_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :ict, :comment => ict_comment, :teacher => ict_teacher, :level => ict_level}


	  music_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "music").id)
	  if music_set.commentos[-1] == nil
	    music_comment = ""
	    missing = true 
	  else
	    music_comment =  music_set.commentos[-1].texto 
	    missing = false
	  end 
	  music_teacher = Teacher.find(skt.music_teacher).name
	  music_level = skt.music_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :music, :comment => music_comment, :teacher => music_teacher, :level => music_level}

	  
	  pe_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "pe").id)
	  if pe_set.commentos[-1] == nil
	    pe_comment = ""
	    missing = true 
	  else
	    pe_comment =  pe_set.commentos[-1].texto 
	    missing = false
	  end 
	  pe_teacher = Teacher.find(skt.pe_teacher).name
	  pe_level = skt.pe_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :pe, :comment => pe_comment, :teacher => pe_teacher, :level => pe_level}


	  thai_set =     skt.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "thai").id)
	  if thai_set.commentos[-1] == nil
	    thai_comment = ""
	    missing = true 
	  else
	    thai_comment =  thai_set.commentos[-1].texto 
	    missing = false
	  end 
	  thai_teacher = Teacher.find(skt.thai_teacher).name
	  thai_level = skt.thai_level
	  student = Student.find(skt.student).name
	  data << {:missing? => missing, :student => student, :subject => :thai, :comment => thai_comment, :teacher => thai_teacher, :level => thai_level}

	end;nil

	sorted_by_subject = data.sort_by {|d| d[:level]};nil

	teachers = [];nil
	data.each {|d| teachers << d[:teacher]};nil
	teachers.uniq!;nil

	subjects = [];nil
	data.each {|d| subjects << d[:subject]};nil
	subjects.uniq!;nil

	doc = ""
	teachers.each do |teacher|
		doc << "\n\n"
		doc << '<div class="page-break"></div>'
		doc << "\n\n#{teacher}\n"
		doc << "#{heading(teacher, 1)}\n\n"
		subjects.each do |subject|
	  	this_sub_only = sorted_by_subject.collect { |e| e if e[:subject] == subject}
	  	this_sub_this_teacher_only = this_sub_only.compact.collect { |e| e if e[:teacher] == teacher }
	  	doc << "\n\n#{Subject.find_by(:subject_id => subject).name}\n" unless this_sub_this_teacher_only.compact.uniq.length == 0
		doc << "#{heading(subject, 2)}\n" unless this_sub_this_teacher_only.compact.uniq.length == 0
		doc << "\n"
		sorted_by_subject.each {|d| doc << "\n\n**#{d[:student]} #{Subject.find_by(:subject_id => subject).name} #{d[:level]}**\n\n#{doublespacer(d[:comment])}" if (d[:teacher] == teacher) && (d[:subject] == subject)}
	  end
	end

	@md = doc

	# Set up the directories all relative to 'base_dir'
	#make it a little bit more portable
	base_dir = "#{Dir.home}/development/rma-reportcards/"
	template_dir = "#{base_dir}views/comment_status/"
	output_dir = "#{base_dir}public/reports/"
	pdf_dir = "#{base_dir}output/pdf/"

	comment = CommentHardcopy.new(doc, template_dir, output_dir)
	@pdf_path = comment.pdf_path
	puts @pdf_path
	#filename = "/home/johnbreedlove/Desktop/new_out.md"
	#File.open(filename, 'w') {|f| f.write(doc)}
	haml :"/admin/create_comment_hardcopy"
end

