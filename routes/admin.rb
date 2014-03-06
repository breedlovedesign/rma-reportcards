# encoding: utf-8
get "/admin" do
	admin?
	@title = "Admin Panel"	
	@quarters = GradingPeriod.all
	haml :"admin/index"
end

post "/admin/go" do
	admin?
	p = params[:admin_form]
	$message = p["message"] unless p["message"] == ""
	
	GradingPeriodPersist.all[0].grading_period = GradingPeriod.find("#{p["current_quarter"]}")
	redirect to('/admin')
end
