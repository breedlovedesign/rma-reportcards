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
