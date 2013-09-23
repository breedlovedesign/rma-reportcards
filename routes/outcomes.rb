# encoding: utf-8

get "/outcomes" do
  @outcomes = Outcome.all
  haml :"outcomes/index"
end