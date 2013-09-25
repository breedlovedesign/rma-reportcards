# encoding: utf-8
post "/outcomes/add_outcome/:mongo_id" do 
 p = params[:add_outcome] 
 outcome_set = OutcomeSet.find(params[:mongo_id])
 outcome = outcome_set.outcomes.push(Outcome.new(:texto => "#{p["item"]}", :indexo => "#{p["index"]}"))
 redirect to("/outcomes/list/#{outcome_set.subject.id}")
end

get "/outcomes/edit/:outcome_id" do
  p = params[:form_data]
  @outcome = Outcome.find_by(:id => params[:outcome_id])
  #@outcome_sets = OutcomeSet.where(:subject => @subject.id)
  haml :"outcomes/list_by_subject"
end

post "/outcomes/delete/:outcome_set_id/:outcome_id" do
  p = params[:form_data]
  outcome_set = OutcomeSet.find_by( :id => params[:outcome_set_id] )
  outcome = outcome_set.outcomes.find_by( :id => params[:outcome_id] )
  outcome.delete
  redirect to("outcomes/list/#{outcome_set.subject.id}")
end

