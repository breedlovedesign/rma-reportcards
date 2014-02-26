# encoding: utf-8
get "/login" do
  @title = "Login"	
  @teachers = Teacher.all
  haml :"login/index", :layout => false
end

get "/retry" do
  @title = "Retry Login"
  @teachers = Teacher.all
  haml :"login/retry", :layout => false
end


post "/login" do
  p = params[:login_form]
  if p["teacher"] == "fail"
    redirect to('/retry')
  elsif p["teacher"] == "admin" && (p["password"] == "computer2")
  	session[:teacher_id] = "admin"
  	session[:role] = "admin"
 	redirect to('/admin')
  elsif p["teacher"] == "admin" && (p["password"] != "computer2")
    session[:teacher_id] = "admin"
  	redirect to('/retry')
  # adding attendance
  elsif p["teacher"] == "attendance" && (p["password"] == "dear")
  session[:teacher_id] = "attendance"
  session[:role] = "attendance"
  redirect to('/attendance')
  elsif p["teacher"] == "attendance" && (p["password"] != "dear")
    session[:teacher_id] = "attendance"
    redirect to('/retry')
  # done adding attendance
  # adding editor
  elsif p["teacher"] == "editor-in-chief" && (p["password"] == "p")
  session[:teacher_id] = "editor-in-chief"
  session[:role] = "editor-in-chief"
  redirect to('/edits/teachers')
  elsif p["teacher"] == "editor-in-chief" && (p["password"] != "p")
    session[:teacher_id] = "editor-in-chief"
    redirect to('/retry')
  # done adding editor
  elsif p["password"] == Teacher.find_by(:id => p["teacher"]).password
  	session[:teacher_id] = Teacher.find_by(:id => p["teacher"]).id
  	session[:role] = "teacher"
  	redirect to('/teachers/students')
  else
    session[:teacher_id] = Teacher.find_by(:id => p["teacher"]).id
  	redirect to('/retry')
  end

end

post "/retry" do
  p = params[:login_form]
  if p["teacher"] == "fail"
    redirect to('/retry')
  elsif p["teacher"] == "admin" && (p["password"] == "computer2")
    session[:teacher_id] = "admin"
    session[:role] = "admin"
  redirect to('/admin')
  elsif p["teacher"] == "admin" && (p["password"] != "computer2")
    session[:teacher_id] = "admin"
    redirect to('/retry')
  # adding attendance
  elsif p["teacher"] == "attendance" && (p["password"] == "dear")
    session[:teacher_id] = "attendance"
    session[:role] = "attendance"
  redirect to('/attendance')
  elsif p["teacher"] == "attendance" && (p["password"] != "dear")
    session[:teacher_id] = "attendance"
    redirect to('/retry')
  # done adding attendance
    # adding editor
  elsif p["teacher"] == "editor-in-chief" && (p["password"] == "p")
  session[:teacher_id] = "editor-in-chief"
  session[:role] = "editor-in-chief"
  redirect to('/edits/teachers')
  elsif p["teacher"] == "editor-in-chief" && (p["password"] != "p")
    session[:teacher_id] = "editor-in-chief"
    redirect to('/retry')
  # done adding editor
  elsif p["password"] == Teacher.find_by(:id => p["teacher"]).password
    session[:teacher_id] = Teacher.find_by(:id => p["teacher"]).id
    session[:role] = "teacher"
    redirect to('/teachers/students')
  else
    session[:teacher_id] = Teacher.find_by(:id => p["teacher"]).id
    redirect to('/retry')
  end

end


get "/logout" do
    session[:teacher_id] = nil
    session[:role] = nil
    redirect to'/login'
end


