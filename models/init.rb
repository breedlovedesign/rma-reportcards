# encoding: utf-8
require 'mongoid'
Mongoid.configure do |config|
  config.sessions = {:default => {:hosts => ["localhost:27017"], :database => "rma-development"}}
end
SUBJECTS = [:language_arts, :math, :social_studies, :science, :art, :ict, :music, :thai, :pe, :work_study, :citizenship]
require_relative "student"
require_relative "teacher"
require_relative "subject"
require_relative "grading_period"
require_relative "skill_track"
require_relative "outcome_set"
require_relative "outcome"
require_relative "attendance_set"
require_relative "report_card"
require_relative "student_var"
require_relative "commento"
require_relative "grading_period_persist"
require_relative "comment_hardcopy"
require_relative "pdf_dl"