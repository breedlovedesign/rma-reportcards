require './init.rb'
StudentVar.new
StudentVar.new(Student.find_by(:name => "BBB").id.to_s)
Student.all.each {|s| s.skill_tracks.each {|tr| p s.id + "   " + tr.grading_period  } }
Student.all.each {|s| s.skill_tracks.each {|tr| p s.id.to_s + "   " + tr.grading_period  } }
Student.all.each {|s| s.skill_tracks.each {|tr| p s.id.to_s + "   " + tr.grading_period.name  } }
Student.all.each {|s| s.skill_tracks.each {|tr| p s.id.to_s + "   " + tr.grading_period.name + tr.student.name  } }
Student.all.each {|s| p s.skill_tracks.length}
Student.all.each {|s| p s.skill_tracks.length + s.name}
Student.all.each {|s| p s.skill_tracks.length.to_s + s.name}
zach = Student.find_by(name: "VVVr")
zach.skill_tracks.each {|tr| tr.id}
zach.skill_tracks.each {|tr| p tr.id}
zach.skill_tracks.each {|tr| p tr.grading_period.name}
zach.skill_tracks[2]
zach.skill_tracks[1]
$current_quarter = "52608932b924a12298000001"
GradingPeriod.all.each {|gp| p gp.id}
zach.skill_tracks[0]
charn = Student.find_by(name: "eeee")
$current_quarter = "5248ea24b924a184d600000c"
StudentVar.new(charn)
student_var = StudentVar.new(charn)
student_var.language_arts_o_g_pairs
skill_track_ids = []; SkillTrack.all.each { |sk| skill_track_ids << sk.id.to_s  }
skill_track_ids
skill_track_ids.each {|a|p a.grading_period}
student_skill_track_ids = []; Student.all.each { |s|  s.skill_tracks.each {|skt| student_skill_track_ids << skt.id.to_s}  }
student_skill_track_ids
bad_ids = skill_track_ids - student_skill_track_ids
bad_ids.each {|id| p SkillTrack.find(id).student_id}
bad_ids.each {|id| print SkillTrack.find(id).student_id}
bad_ids.each {|id| print Student.find(SkillTrack.find(id).student_id).name}
# bad_ids.each {|id| SkillTrack.delete(id)} not the right way...
# bad_ids.each {|id| SkillTrack.find(id)}
# bad_ids.each {|id| p SkillTrack.find(id).student_id.to_s}
# bad_ids.each {|id| SkillTrack.delete_all(id: id)}
bad_ids.each {|id| SkillTrack.find(id).delete} #=> works
SkillTrack.all.length
exit
