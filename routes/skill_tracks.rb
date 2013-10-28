# encoding: utf-8
@levels = ["L12", "L34", "L56", "L78"]


get "/skill_tracks" do
	admin?
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
	admin?
  form = params[:grap]
  # look at all skill tracks, list those that belong to this student
  # of those, are any already for this quarter? If no, make new. If yes edit
  student = Student.find("#{ form["kid_id"] }")
  grading_period = GradingPeriod.find("#{ form["quarter_id"] }")
  old_track = SkillTrack.where(:student => student.id, :grading_period => grading_period.id )[0]

  if old_track.nil?
    skill_track_obj = student.skill_tracks.create
    skill_track_obj.grading_period = grading_period
    skill_track_obj.save
    redirect to("/skill_tracks/edit/#{skill_track_obj.id}")
  else
    redirect to("/skill_tracks/edit/#{old_track.id}")
  end

end

post "/students/new" do
	admin?
  p = params[:student]
  Student.where( :name => p["name"], :nickname => p["nickname"] ).create
  redirect to('/students')
end

get "/skill_tracks/edit/:mongo_id" do
	admin?
  @title = "Skill Tracking"
  @students = Student.all
  @grading_periods = GradingPeriod.all
  @skill_tracks = SkillTrack.all
  @teachers = Teacher.all
  @levels  = ["", "L12", "L34", "L56", "L78" ]
  @student_levels  = [ "", "1", "2", "3", "4", "5", "6", "7", "8" ]
  @eal_sss_status = ["", "None", "EAL", "SSS"]
  @thai_native = ["", "Native", "Non-Native"]
  @this_track = SkillTrack.find("#{params[:mongo_id]}")
  @kid = Student.find("#{@this_track.student.id}")
  haml :"skill_tracks/edit"
end

post "/skill_tracks/update/:mongo_id" do
	admin?
  form = params[:form_data]
  this_track = SkillTrack.find(params[:mongo_id])
  this_track.teacher = Teacher.find("#{ form["homeroom_teacher"] }")                      unless form["homeroom_teacher"]      == ""
  this_track.update_attributes!(:student_level          => form["student_level"])         unless form["student_level"]         == ""

  this_track.update_attributes!(:language_arts_teacher  => form["language_arts_teacher"]) unless form["language_arts_teacher"] == ""
  this_track.update_attributes!(:language_arts_level    => form["language_arts_level"])   unless form["language_arts_level"]   == ""
  this_track.update_attributes!(:social_studies_teacher => form["language_arts_teacher"]) unless form["language_arts_teacher"] == ""
  this_track.update_attributes!(:social_studies_level   => form["language_arts_level"])   unless form["language_arts_level"]   == ""
  this_track.update_attributes!(:science_teacher        => form["language_arts_teacher"]) unless form["language_arts_teacher"] == ""
  this_track.update_attributes!(:science_level          => form["language_arts_level"])   unless form["language_arts_level"]   == ""

  this_track.update_attributes!(:math_teacher           => form["math_teacher"])          unless form["math_teacher"]          == ""
  this_track.update_attributes!(:math_level             => form["math_level"])            unless form["math_level"]            == ""

  this_track.update_attributes!(:art_teacher            => form["art_teacher"])           unless form["art_teacher"]           == ""
  this_track.update_attributes!(:art_level              => form["art_level"])             unless form["art_level"]             == ""
  this_track.update_attributes!(:ict_teacher            => form["ict_teacher"])           unless form["ict_teacher"]           == ""
  this_track.update_attributes!(:ict_level              => form["ict_level"])             unless form["ict_level"]             == ""
  this_track.update_attributes!(:music_teacher          => form["music_teacher"])         unless form["music_teacher"]         == ""
  this_track.update_attributes!(:music_level            => form["music_level"])           unless form["music_level"]           == ""
  this_track.update_attributes!(:pe_teacher             => form["pe_teacher"])            unless form["pe_teacher"]            == ""
  this_track.update_attributes!(:pe_level               => form["pe_level"])              unless form["pe_level"]              == ""
  this_track.update_attributes!(:thai_teacher           => form["thai_teacher"])          unless form["thai_teacher"]          == ""
  this_track.update_attributes!(:thai_level             => form["thai_level"])            unless form["thai_level"]            == ""

  this_track.update_attributes!(:work_study_teacher     => form["work_study_teacher"])    unless form["work_study_teacher"]    == ""
  this_track.update_attributes!(:work_study_level       => form["work_study_level"])      unless form["work_study_level"]      == ""
  this_track.update_attributes!(:citizenship_teacher    => form["work_study_teacher"])    unless form["work_study_teacher"]    == ""
  this_track.update_attributes!(:citizenship_level      => form["work_study_level"])      unless form["work_study_level"]      == ""

  this_track.update_attributes!(:eal_sss_status         => form["eal_sss_status"])        unless form["eal_sss_status"]        == ""
  this_track.update_attributes!(:thai_native            => form["thai_native"])           unless form["thai_native"]           == ""
  this_track.save
  redirect to("/skill_tracks/edit/#{params[:mongo_id]}")
end
post "/students/update/:mongo_id" do
	admin?
  form = params[:form_data_2]
  pants = Student.find(params[:mongo_id])
  pants.update_attributes!(:nickname => form["nickname"]) unless form["nickname"] == ""
  pants.update_attributes!(:name => form["name"]) unless form["name"] == ""
  redirect to("/students/edit/#{params[:mongo_id]}")
end


get "/skill_tracks/:mongo_id" do
	admin?
  @title = "Skill Tracking"
  @skill_tracks = SkillTrack.all
  haml :"skill_tracks/index"
end