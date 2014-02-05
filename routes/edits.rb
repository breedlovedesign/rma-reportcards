get '/edits/teachers' do
  @title = "Peer Editing"	
  @teachers = Teacher.all
  haml :"edits/teachers", :layout => :teacher_layout
end

get "/edits/:teacher_id" do
	@teacher  = Teacher.find_by(:id => params[:teacher_id])
	@students = Student.all.map do |student|
		if student.current_skill_track.has_teacher(@teacher.id.to_s)
			student # build a list in @students of this teacher's students
		end
	end
	@students.compact!
	@subjects = @students.map do |student|
		student.current_skill_track.which_subjects(@teacher.id.to_s)
	end
	@subjects = @subjects.flatten.uniq
	haml :"edits/teacher_subjects", :layout => :teacher_layout
end