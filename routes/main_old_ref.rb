# encoding: utf-8
require "sinatra"
require "bundler/setup"
require "haml"
require "mongoid"
require "sinatra/flash"
require "sinatra/form_helpers"
require "sinatra/simple-navigation"

# not using just yet
# require 'test/unit'
# require 'rack/test'
# 
# class Test::Unit::TestCase
#   include Rack::Test::Methods
# end

configure do
  Mongoid.configure do |config|
    config.sessions = {:default => {:hosts => ["localhost:27017"], :database => "rma"}}
  end
end
#SimpleNavigation::config_file_paths << "/Users/localadmin/development/rma/simplenav.config"

SUBJECTS = [:language_arts, :math, :social_studies, :science, :art, :ict, :music, :thai, :pe, :work_study, :citizenship]

class Teacher
  include Mongoid::Document
  field :teacher_id
  field :name
end

class Student
  include Mongoid::Document
  field :student_id
  field :name
  field :nickname
  field :dob
  field :eal_sss_status
  field :dob, type: Date
end

class School_Year
  include Mongoid::Document
  field :language_arts_teacher
  field :math_teacher
  field :social_studies_teacher
  field :science_teacher
  field :art_teacher
  field :ict_teacher
  field :music_teacher
  field :thai_teacher
  field :pe_teacher
  field :work_study_teacher
  field :citizenship_teacher

  field :language_arts_level
  field :math_level
  field :social_studies_level
  field :science_level
  field :art_level
  field :ict_level
  field :music_level
  field :thai_level
  field :pe_level
  field :work_study_level
  field :citizenship_level

  belongs_to :student
end

class Subject
  include Mongoid::Document
  field :subject_id
  field :name
end

class GradingPeriod
  include Mongoid::Document
  field :signing_date  #October 11, 2013
  field :year          #2012-2013
  field :period        #Quarer 1
end

get "/" do
  @students = Student.all
  @teachers = Teacher.all
  haml :index
end

get "/teachers" do
  @teachers = Teacher.all
  haml :"teachers/index"
end

post "/teachers/new" do 
  p = params[:teacher]
  Teacher.where(name: p["name"], teacher_id: p["teacher_id"]).create 
  redirect to('/teachers')
end

delete '/teachers/delete/:id' do
  Teacher.where(id: params[:id]).destroy
  redirect to('/teachers')
end

get "/students" do
  @students = Student.all
  haml :"students/index"
end

post "/students/new" do 
  p = params[:student]
  Student.where(:name => p["name"], :student_id => p["student_id"], :eal_sss_status => "None").create 
  redirect to('/students')
end

delete '/students/delete/:id' do
  Student.where(id: params[:id]).destroy
  redirect to('/students')
end

get "/students/edit/:mongo_id" do
  @student = Student.find_by(id: params[:mongo_id])
  haml :"students/edit"
end

post "/students/update/:mongo_id" do 
  form = params[:form_data_2]
  pants = Student.find(params[:mongo_id])
  pants.update_attributes!(:nickname => form["nickname"]) unless form["nickname"] == ""
  pants.update_attributes!(:name => form["name"]) unless form["name"] == ""
  pants.update_attributes!(:eal_sss_status => form["eal_sss_status"]) unless form["eal_sss_status"] == nil
  redirect to("/students/edit/#{params[:mongo_id]}")
end

post "/students/delete_nickname/:mongo_id" do
  Student.where(:id => params[:mongo_id]).unset(:nickname)
  redirect to("/students/edit/#{params[:mongo_id]}")
end

post "/students/dob/:mongo_id" do 
  form = params[:form_data_3]
  pants = Student.find(params[:mongo_id])
  pants.update_attributes!(:dob => form["dob"]) unless form["dob"] == ""
  redirect to("/students/edit/#{params[:mongo_id]}")
end

###################### Subjects ######################

get "/subjects" do
  @subjects = Subject.all
  haml :"subjects/index"
end

post "/subjects/new" do 
  p = params[:subject]
  Subject.where(name: p["name"], subject_id: p["subject_id"]).create 
  redirect to('/subjects')
end

delete '/subjects/delete/:id' do
  Subject.where(id: params[:id]).destroy
  redirect to('/subjects')
end

get "/subjects/edit/:mongo_id" do
  @subject = Subject.find_by(id: params[:mongo_id])
  haml :"subjects/edit"   
end

post "/subjects/update/:mongo_id" do 
  form = params[:form_data_2]
  pants = Subject.find(params[:mongo_id])
  pants.update_attributes!(:subject_id => form["subject_id"]) unless form["subject_id"] == ""
  pants.update_attributes!(:name => form["name"]) unless form["name"] == ""
  redirect to("/subjects/edit/#{params[:mongo_id]}")
end

###################### Grading Period ######################

get "/grading_period" do
  @grading_period = GradingPeriod.all

  haml :"grading_period/index"
end


###################### drop down exp #######################

get "/drop_down" do 
  @subjects = Subject.all
  @students = Student.all
  @teachers = Teacher.all
  @subs     = Student::SUBJECTS
  haml :"drop_down_exp/index"
end

# todo: add preselected values corrosponding to the data in question



















