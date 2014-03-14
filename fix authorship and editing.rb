# in pry on the server after updating, before starting server
# this command creates a place for a new database to store the current quarter
gp_per = GradingPeriodPersist.new
gp = GradingPeriod.all[2]
gp_per = gp
gp_per.save


SkillTrack.all.each do |trk|
  trk.outcome_sets.each do |set|
  	sub = Subject.find("#{set.subject_id}")
  	puts "................................................."
  	p sub.name
  	puts "................................................."
    set.commentos.each do |com|
      method_name = "#{sub.subject_id}_teacher".to_sym
      teacher_id = trk.send(method_name)
      p Teacher.find(teacher_id).name
      com.editor = ""
      com.author = teacher_id

    end

  end
end; nil



  	
    set.commentos.each do |com|
      p com.editor
      p com.author
    end








#<Commento _id: 53191e2b7e225c098a00000f, c_at(created_at): 2014-03-07 01:17:31 UTC, texto: "Sale has read a wide variety of stories and she can talk about the characters and situations with good recall.&nbsp; Sale has not made much progress in the areas of writing.&nbsp; She has some good ideas during discussions but fails to produce the finished goods as she gets distracted and loses the thread of what she was writing.&nbsp; However, she has started completing her work at home and with practice might increase her writing speed.&nbsp; Sale enjoys and participates enthusiastically in group discussions.", indexo: nil, author: "", editor: "", author_approval: false, eic_approval: false>


#Change Salemata's Language Arts Skill Tracking to 56 from 34 and keep kala's comments

require './init.rb'
gp_per = GradingPeriodPersist.all[0]
GradingPeriod.each {|g| p g.inspect};nil
sale = Student.find_by(name: "Salemata Diallo")
gp = GradingPeriod.find("53118d9b270a990c4d000001")
sale_skill_track = sale.skill_tracks.find_by(grading_period: gp)
sale_skill_track.outcome_sets.count # should be 11
la_id = Subject.find_by(name: "Language Arts").id
language_set = sale_skill_track.outcome_sets.find_by(subject_id: la_id)
# grab the comments all commentos embedded in the outcome_set
temp_container = language_set.commentos
l34_outcome = sale_skill_track.outcome_sets.find_by(:level => "L34", :subject => la_id)
l34_outcome.delete
language_set.inspect
# change the level through the web interface
sale_skill_track.outcome_sets.push( OutcomeSet.find_by(:subject => Subject.find_by(:subject_id => "language_arts").id, :level => sale_skill_track.language_arts_level).clone )
# given gp = the correct grading period object, this command sets all the outcome
# sets (be sure the skill tracking info is done well first)
gp.skill_tracks.each {|skill_track| skill_track.get_outcome_sets}










