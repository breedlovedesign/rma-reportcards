# encoding: utf-8
get "/teacher/:id" do
  teacher?
  @students = Student
end

get "/teachers/students" do
  teacher?
  logged_in_teacher = Teacher.find_by(:id => session[:teacher_id])
  @title = "#{logged_in_teacher.name}'s Students" 
  students = Student.all
  @students = []

  students.each do |student|
    tracks = student.skill_tracks.where(:grading_period => $current_quarter)
    tracks.each do |track|
      if track.has_teacher(logged_in_teacher.id.to_s)
        @students << student
      end
    end
    
  end
  haml :"/teachers/students", :layout => :teacher_layout
end