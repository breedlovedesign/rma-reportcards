# encoding: utf-8
get "/login" do
  @title = "Login"	
  @teachers = Teacher.all
  haml :"login/index"
end

post "/login/go" do 
  p = params[:login_form]
  if p["teacher"] == "admin" && (p["password"] == "computer2")
  	session[:teacher_id] = "admin"
 	redirect to('/admin')
  elsif p["teacher"] == "admin" && (p["password"] != "computer2")
  	redirect to('/login')
  elsif p["password"] == Teacher.find_by(:id => p["teacher"]).password
  	session[:teacher_id] = Teacher.find_by(:id => p["teacher"]).id
  	redirect to('/teachers/students')
  end
  
end

get "/teachers/students" do
	quarter = GradingPeriod.find_by(:id => "5248ea24b924a184d600000c")
	logged_in_teacher = Teacher.find_by(:id => session[:teacher_id])
	@title = "#{logged_in_teacher.name}'s Students"	
	students = Student.all
	@students = []

	students.each do |student|
		tracks = student.skill_tracks.where(:grading_period => quarter.id)
		tracks.each do |track|
			if track.has_teacher(logged_in_teacher.id.to_s)
				@students << student
			end
		end
		
	end


  haml :"/teachers/students"
end

