# encoding: utf-8
get "/attendance" do
	attendance?
	@title = "Attendance Panel"	
	@students = Student.all
	haml :"attendance/index", :layout => :attendance_layout
end

post "/attendance/edit/:mongo_id" do
	attendance?
	p = params[:attendance_form]
	student = Student.find_by(:id => params[:mongo_id])
	
	student.attendance_set.q1_days = p["q1_days"] unless p["q1_days"] == ""
	student.attendance_set.q2_days = p["q2_days"] unless p["q2_days"] == ""
	student.attendance_set.q3_days = p["q3_days"] unless p["q3_days"] == ""
	student.attendance_set.q4_days = p["q4_days"] unless p["q4_days"] == ""
	
	student.attendance_set.q1_tardy = p["q1_tardy"] unless p["q1_tardy"] == ""
	student.attendance_set.q2_tardy = p["q2_tardy"] unless p["q2_tardy"] == ""
	student.attendance_set.q3_tardy = p["q3_tardy"] unless p["q3_tardy"] == ""
	student.attendance_set.q4_tardy = p["q4_tardy"] unless p["q4_tardy"] == ""

	student.attendance_set.q1_absence = p["q1_absence"] unless p["q1_absence"] == ""
	student.attendance_set.q2_absence = p["q2_absence"] unless p["q2_absence"] == ""
	student.attendance_set.q3_absence = p["q3_absence"] unless p["q3_absence"] == ""
	student.attendance_set.q4_absence = p["q4_absence"] unless p["q4_absence"] == ""

	student.attendance_set.save
	redirect to('/attendance')
end
