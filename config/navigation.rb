SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :home,           'Home',             "/"
    primary.item :teachers,       'Teachers',         "/teachers"
    primary.item :students,       'Students',         "/students"
    primary.item :subjects,       'Subjects',         "/subjects"
    primary.item :grading_period, "Grading Periods",  "/grading_periods"
    primary.item :skill_tracks,   "Skill Tracking",   "/skill_tracks"
  end
end