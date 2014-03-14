# encoding: utf-8
class RmaReports < Sinatra::Application
	get "/" do
		@title = "RMA REPORTS"
		@students = Student.all
		@teachers = Teacher.all
		haml :index, :layout => :nobody_layout
	end
	get	"/learn" do
		@title = "learn sinatra"
		haml :learn, :layout => :teacher_layout
	end
end