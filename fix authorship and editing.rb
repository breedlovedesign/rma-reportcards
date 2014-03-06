# in pry on the server after updating, before starting server
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

