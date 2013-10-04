# encoding: utf-8
require "sinatra"
require "bundler/setup"
require "haml"
require "mongoid"
require "sinatra/flash"
require "digest/sha1"
#require "rack-flash"
#require "sinatra-authentication"
require "sinatra/form_helpers"
require "sinatra/simple-navigation"
#require 'sinatra/simple_auth'



require_relative 'main'
require_relative 'students'
require_relative 'teachers'
require_relative 'subjects'
require_relative 'grading_periods'
require_relative 'skill_tracks'
require_relative 'outcome_sets'
require_relative 'outcomes'
require_relative 'login'
