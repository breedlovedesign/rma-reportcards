# encoding: utf-8
require 'mongoid'
Mongoid.configure do |config|
  config.sessions = {:default => {:hosts => ["localhost:27017"], :database => "rma-development"}}
end
SUBJECTS = [:language_arts, :math, :social_studies, :science, :art, :ict, :music, :thai, :pe, :work_study, :citizenship]
require_relative 'user'
require_relative "student"
require_relative "teacher"
require_relative "subject"
require_relative "grading_period"
#require_relative ""
require_relative "skill_track"