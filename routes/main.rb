# encoding: utf-8
class RmaReports < Sinatra::Application
	get "/" do
		@title = "Progress so far…"
		@students = Student.all
		@teachers = Teacher.all
		haml :index, :layout => :nobody_layout
	end
end