# encoding: utf-8
get "/subjects" do
  @title = "Subjects"	
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