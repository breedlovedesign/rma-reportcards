SkillTrack.all.each do |trk|
  trk.outcome_sets.each do |set|
    set.commentos.each |com|
    com.editor = ""
    com.author = "#{trk.}"

  end
end