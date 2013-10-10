# encoding: utf-8
get "/attendance" do
	attendance?
	@title = "Attendance Panel"	
	@students = Student.all
	haml :"attendance/index"
end

post "/attendance/go" do
	attendance?
	p = params[:attendance_form]
	$current_quarter = p["current_quarter"]
	redirect to('/admin')
end
