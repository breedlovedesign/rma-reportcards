# encoding: utf-8
require "sinatra"
require "bundler/setup"
require "haml"
require "mongoid"
require "sinatra/flash"
require "sinatra/form_helpers"
require "sinatra/simple-navigation"
require 'pp'
require 'stamp'

require_relative 'main'
require_relative 'students'
require_relative 'teachers'
require_relative 'subjects'
require_relative 'grading_periods'
require_relative 'skill_tracks'
require_relative 'outcomes'
require_relative 'login'
require_relative 'admin'
require_relative 'teacher_landing'
require_relative 'grades_and_comments'
require_relative 'report_generator'
require_relative 'attendance'
require_relative 'edits'