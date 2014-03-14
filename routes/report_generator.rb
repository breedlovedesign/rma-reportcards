post "/admin/create_report/:mongo_id" do


# Set up the directories all relative to 'base_dir'
#make it a little bit more portable
base_dir = "#{Dir.home}/development/rma-reportcards/"
template_dir = "#{base_dir}views/reports/"
output_dir = "#{base_dir}public/reports/"
pdf_dir = "#{base_dir}output/pdf/"

stu = Student.find("#{params[:mongo_id]}")
student_var = StudentVar.new(stu.id)
report = ReportCard.new(student_var, template_dir, output_dir)

# `html2pdf --papersize=a4  #{output_dir}*html` 
# 	`rm #{output_dir}*html`
# 	#timestamp = Time.now.stamp()
# 	`pdfjam  --a3paper --nup 2x1 --landscape  #{output_dir}*pdf 4,1,2,3 --outfile #{output_dir}output.pdf`

redirect to("/admin")
end

post "/admin/create_reports" do
	base_dir = "#{Dir.home}/development/rma-reportcards/"
	template_dir = "#{base_dir}views/reports/"
	output_dir = "#{base_dir}public/reports/"
	pdf_dir = "#{base_dir}output/pdf/"

	Student.all.each do |stu|
		if stu.skill_tracks.where(:grading_period_id => GradingPeriod.find(GradingPeriodPersist.all[0].grading_period.id.to_s)).exists?
			student_var = StudentVar.new(stu.id)
			report = ReportCard.new(student_var, template_dir, output_dir) 			
		end
	end

	`html2pdf --papersize=a4  #{output_dir}*html` 
	`rm #{output_dir}*html`
	#timestamp = Time.now.stamp()
	`pdfjam  --a3paper --nup 2x1 --landscape  #{output_dir}*pdf 4,1,2,3 --outfile #{output_dir}output.pdf`

	redirect to("/admin")
end