get "/skill_tracks" do
  @title = "Skill Tracking"
  @skill_tracks = SkillTrack.all
  haml :"skill_tracks/index"
end