# encoding: utf-8
class RmaReports < Sinatra::Application
	get "/" do
		@title = "Get your report on!"				
    @students = Student.all
    @teachers = Teacher.all
    haml :index
	end
end