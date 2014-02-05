# encoding: utf-8
class RmaReports < Sinatra::Application
	get "/" do
		@title = "RMA REPORTS"
		@students = Student.all
		@teachers = Teacher.all
		haml :index, :layout => :nobody_layout
	end
end