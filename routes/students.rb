# encoding: utf-8
get "/students" do
	admin?
  @title = "Students"
  @students = Student.all
  haml :"students/index"
end

post "/students/new" do
	admin?
  p = params[:student]
  Student.where( :name => p["name"], :nickname => p["nickname"], :dob => p["dob"] ).create
  redirect to('/students')
end

delete '/students/delete/:id' do
	admin?
  Student.where(id: params[:id]).destroy
  redirect to('/students')
end

get "/students/edit/:mongo_id" do
	admin?
  @student = Student.find_by(id: params[:mongo_id])
  haml :"students/edit"
end

post "/students/update/:mongo_id" do
	admin?
  form = params[:form_data_2]
  pants = Student.find(params[:mongo_id])
  pants.update_attributes!(:nickname => form["nickname"]) unless form["nickname"] == ""
  pants.update_attributes!(:name => form["name"]) unless form["name"] == ""
  #redirect to("/students/edit/#{params[:mongo_id]}")
  redirect to("/students")
end

post "/students/delete_nickname/:mongo_id" do
	admin?
  Student.where(:id => params[:mongo_id]).unset(:nickname)
  redirect to("/students/edit/#{params[:mongo_id]}")
end

post "/students/dob/:mongo_id" do
	admin?
  form = params[:form_data_3]
  pants = Student.find(params[:mongo_id])
  pants.update_attributes!(:dob => form["dob"]) unless form["dob"] == ""
  redirect to("/students/edit/#{params[:mongo_id]}")
end