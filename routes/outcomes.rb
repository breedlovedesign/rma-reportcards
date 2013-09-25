# encoding: utf-8
post "/outcomes/add_outcome/:mongo_id" do 
 p = params[:add_outcome] 
 outcome_set = OutcomeSet.find(params[:mongo_id])
 outcome = outcome_set.outcomes.push(Outcome.new(:texto => "#{p["item"]}", :indexo => "#{p["index"]}"))
 redirect to("/outcomes/list/#{outcome_set.subject.id}")
end

get "/outcomes/edit/:outcome_set_id/:outcome_id" do
  p = params[:form_data]
  @outcome_set = OutcomeSet.find_by( :id => params[:outcome_set_id] )
  @outcome = @outcome_set.outcomes.find_by( :id => params[:outcome_id] )
  haml :"outcomes/edit_outcome"
end

post "/outcomes/delete/:outcome_set_id/:outcome_id" do
  outcome_set = OutcomeSet.find_by( :id => params[:outcome_set_id] )
  outcome = outcome_set.outcomes.find_by( :id => params[:outcome_id] )
  outcome.delete
  redirect to("outcomes/list/#{outcome_set.subject.id}")
end

post "/outcomes/update_outcome/:outcome_set_id/:outcome_id" do
  p = params[:update_outcome]
  outcome_set = OutcomeSet.find_by( :id => params[:outcome_set_id] )
  outcome = outcome_set.outcomes.find_by( :id => params[:outcome_id] )
  outcome.update_attributes!(:texto =>  p["item"]) unless p["item"] == ""
  outcome.update_attributes!(:indexo => p["index"]) unless p["index"] == ""
  redirect to("outcomes/list/#{outcome_set.subject.id}")
end


get "/outcomes" do
  @outcomes = Outcome.all
  @subjects = Subject.all
  @levels = ["", "L12", "L34", "L56", "L78", "L12-Native", "L34-Native", "L56-Native", "L78-Native"  ]
  haml :"outcomes/index"
end

post "/outcomes/new" do 
  p = params[:form_data]
  o = Outcome.where(:subject => p["subject"], :level => p["level"]).create 
  redirect to("/outcomes/edit/#{o.id}")
end

get "/outcomes/edit/:mongo_id" do
  p = params[:form_data]
  @outcome = Outcome.find_by(:id => params[:mongo_id])
  @subject = @outcome.subject
  haml :"outcomes/edit"
end

post "/outcomes/update/:mongo_id" do
  p = params[:form_data]
  @outcome = Outcome.find_by(:id => params[:mongo_id])
  @subject = @outcome.subject
  @outcome.update_attributes!()
  redirect to("/outcomes/subject/#{@subject.subject_id}")
end

# 
# get "/outcomes/subject/:subject" do
#   @subject = Subject.find_by(:subject_id => params[:subject])
#   @outcomes = Outcome.find_by(:subject => @subject.id)
#   haml :"outcomes/show"
# end

get "/outcomes/list/:subject_id" do
  p = params[:form_data]
  @subject = Subject.find_by(:id => params[:subject_id])
  @outcome_sets = OutcomeSet.where(:subject => @subject.id)
  haml :"outcomes/list_by_subject"
end


