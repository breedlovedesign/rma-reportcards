# encoding: utf-8
class RmaReports < Sinatra::Application
	get "/" do
		@title = "Welcome to RmaReports"				
    @students = Student.all
    @teachers = Teacher.all
    haml :index
	end
end