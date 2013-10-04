# encoding: utf-8
get "/teachers" do
  @title = "Teachers"	
  @teachers = Teacher.all
  haml :"teachers/index"
end

post "/teachers/new" do 
  p = params[:teacher]
  Teacher.where(name: p["name"]).create 
  redirect to('/teachers')
end

delete '/teachers/delete/:id' do
  Teacher.where(id: params[:id]).destroy
  redirect to('/teachers')
end

get "/teachers/edit/:mongo_id" do
  @teacher = Teacher.find_by(id: params[:mongo_id])
  haml :"teachers/edit"
end

post "/teachers/update/:mongo_id" do 
  form = params[:form_data_2]
  pants = Teacher.find(params[:mongo_id])
  pants.update_attributes!(:password => form["password"]) unless form["password"] == ""
  pants.update_attributes!(:name => form["name"]) unless form["name"] == ""
  #redirect to("/teachers/edit/#{params[:mongo_id]}")
  redirect to("/teachers")
end

get "/teacher/:id" do
	@students = Student
end