get "/skill_tracks" do
  @title = "Skill Tracking"
  @students = Student.all
  @grading_periods = GradingPeriod.all
  @skill_tracks = SkillTrack.all
  @teachers = Teacher.all
#   jstudent = Student.find("5239bd2e4c114ff6b4000001")
#   @child = jstudent.skill_tracks.create( "student_level" => "L34")
#   @plurb = jstudent
  haml :"skill_tracks/index"
end

post "/skill_track/new" do
  form = params[:grap]
  student = Student.find("#{ form["kid_id"] }") 
  skill_track_obj = student.skill_tracks.create
  skill_track_obj.teacher = Teacher.find("#{ form["teacher_id"] }")
  skill_track_obj.grading_period = GradingPeriod.find("#{ form["quarter_id"] }")
  if true # TODO make logic to avoid duplicate skill tracking information 
    skill_track_obj.save
    redirect to("/skill_tracks/edit/#{skill_track_obj.id}")
  end
end

post "/students/new" do 
  p = params[:student]
  Student.where( :name => p["name"], :nickname => p["nickname"] ).create 
  redirect to('/students')
end

get "/skill_tracks/edit/:mongo_id" do
  haml :"skill_tracks/edit"
end

get "/skill_tracks/:mongo_id" do
  @title = "Skill Tracking"
  @skill_tracks = SkillTrack.all
  haml :"skill_tracks/index"
end