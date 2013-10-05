# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :home,                'Home',             "/"
    primary.item :teachers,            'Teachers',         "/teachers"
    primary.item :students,            'Students',         "/students"
    primary.item :subjects,            'Subjects',         "/subjects"
    primary.item :grading_period,      "Grading Periods",  "/grading_periods"
    primary.item :skill_tracks,        "Skill Tracking",   "/skill_tracks"
    primary.item :outcomes,            "Outcomes",         "/outcomes" do |outcome|
      outcome.item :la,                   "Language Arts",       "/outcomes/language_arts"   
      outcome.item :math,                 "Mathematics",         "/outcomes/math"
      outcome.item :social_studies,       "Social Studies",      "/outcomes/social_studies"
      outcome.item :science,              "Science",             "/outcomes/science"
      outcome.item :work_study,           "Work & Study Habits", "/outcomes/work_study"
      outcome.item :citizenship,          "Citzenship",          "/outcomes/citzenship"
      outcome.item :art,                  "Art",                 "/outcomes/art"
      outcome.item :ict,                  "ICT",                 "/outcomes/ict"
      outcome.item :music,                "Music",               "/outcomes/music"
      outcome.item :pe,                   "PE",                 "/outcomes/pe"
      outcome.item :thai,                 "Thai",                 "/outcomes/thai"
    end
    primary.item :logout,              "Logout",            "/logout"  
  end
end 