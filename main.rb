
require "sinatra"
require "bundler/setup"
require "haml"
require "mongoid"
require "sinatra/flash"
require "sinatra/form_helpers"
require "sinatra/simple-navigation"

configure do
  Mongoid.configure do |config|
    config.sessions = {:default => {:hosts => ["localhost:27017"], :database => "rma"}}
  end
end
#SimpleNavigation::config_file_paths << "/Users/localadmin/development/rma/simplenav.config"



class Teacher
  include Mongoid::Document
  field :teacher_id
  field :name
  belongs_to :subject
end

class Student
  include Mongoid::Document
  field :student_id
  field :name
  field :nickname
  field :dob
  #field :eal?
  #field :sss?
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
  Student.where(name: p["name"], student_id: p["student_id"]).create 
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
  redirect to("/students/edit/#{params[:mongo_id]}")
end

post "/students/delete_nickname/:mongo_id" do
  Student.where(:id => params[:mongo_id]).unset(:nickname)
  redirect to("/students/edit/#{params[:mongo_id]}")
end


###################### Subjects################

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

# UNUSED ROUTE
# get "/students/skill-tracking/:id" do
#   @students = Student.all
#   haml :"students/index"
# end

#Teacher.where(teacher_id: "kala", name: "Kala Khanna").create

# post "/students/update/:mongo_id" do 
#   pants = Student.find(params[:mongo_id])
#   pants.update_attributes!(:nickname => "worked")
#   redirect to("/students")
# end







# get "/" do
#   @user = User.all
#   haml :index
# end
# 
# get "/user/:teacher" do
#   @user = User.where(teacher: params[:teacher]) 
#   haml :index
# end
# #User.where(teacher: nil).update_all(teacher: "kala")
# post "/" do
#   pi = params[:user]
#   #puts pi
#   User.where(name: pi["name"]).create 
#   redirect to('/')
# end
# 
# # put '/user/:id' do
# #   person = User.get params[:id]
# #   person.teacher = person.teacher.nil? ? "colin" : nil
# #   person.save
# #   redirect to('/')
# # end
# 
# delete '/user/:id' do
#   User.where(id: params[:id]).destroy
#   redirect to('/')
# end
# 
# get '/users' do
#   person = User.new(:name => "Anise", :age => 60)
#     person.save
#   "Hello, I am #{person.name} and I am #{person.age} years old. There are now #{User.count} of us in here."
# end
# 
# names = User.all.pluck(:name).uniq
# puts "there are #{names.length} students and their names are:"
# puts names
# 
# `open "/Applications/Google Chrome.app" http://0.0.0.0:4567/`
