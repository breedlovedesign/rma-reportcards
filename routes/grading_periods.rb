# encoding: utf-8
get "/grading_periods" do
	admin?
	@title = "Grading Periods"
	@gperiods = GradingPeriod.all
	haml :"grading_periods/index"
end

post "/grading_periods/new" do
  admin?
	p = params[:gp_form_1]
	GradingPeriod.where(:school_year => p["school_year"], :period_name => p["period_name"], :signing_date => p["signing_date"]).create
	redirect to('/grading_periods')
end

delete '/grading_periods/delete/:mongo_id' do
	admin?
 GradingPeriod.where(id: params[:mongo_id]).destroy
	redirect to('/grading_periods')
end

get "/grading_period/edit/:mongo_id" do
	admin?
	@this_grading_period = GradingPeriod.find_by(id: params[:mongo_id])
	haml :"grading_periods/edit"
end

post "/grading_period/update/:mongo_id" do
  admin?
	form = params[:gp_edit_form]
	pants = GradingPeriod.find(params[:mongo_id])
	pants.update_attributes!(:school_year => form["school_year"]) unless form["school_year"] == ""
	pants.update_attributes!(:period_name => form["period_name"]) unless form["period_name"] == ""
	pants.update_attributes!(:signing_date => form["signing_date"]) unless form["signing_date"] == ""
	redirect to("/grading_period/edit/#{params[:mongo_id]}")
end
