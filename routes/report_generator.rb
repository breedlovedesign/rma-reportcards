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

`#{base_dir}vendor/wkhtmltox/bin/wkhtmltopdf -s a4 -T 0 -B 0 -L 0 -R 0 #{output_dir + report.name_of_file}.html #{output_dir + "PDF/A4/" + report.name_of_file}.pdf`
`pdfjam  --a3paper --nup 2x1 --landscape  #{output_dir}PDF/A4/#{report.name_of_file}.pdf 4,1,2,3 --outfile #{output_dir}PDF/A3/#{report.name_of_file}.pdf`

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
			#{}`xvfb-run --server-args="-screen 0, 1024x768x24" wkhtmltopdf --use-xserver -s a4 -T 0 -B 0 -L 0 -R 0 #{output_dir + report.name_of_file}.html #{output_dir + report.name_of_file}.pdf`
			`#{base_dir}vendor/wkhtmltox/bin/wkhtmltopdf -s a4 -T 0 -B 0 -L 0 -R 0 #{output_dir + report.name_of_file}.html #{output_dir + report.name_of_file}.pdf`
		end
	end

	# # on macbook: `html2pdf --papersize=a4  #{output_dir}*html` 
	`pdfjam  --a3paper --nup 2x1 --landscape  #{output_dir}*pdf 4,1,2,3 --outfile #{output_dir}PDF/A3/output.pdf`
	`mv #{output_dir}*pdf #{output_dir}PDF/A4/`
	redirect to("/admin")
end