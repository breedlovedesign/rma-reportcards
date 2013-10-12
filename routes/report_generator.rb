post "/admin/create_report/:mongo_id" do


# Set up the directories all relative to 'base_dir'
base_dir = "/Users/localadmin/development/rma-reportcards/"
template_dir = "#{base_dir}views/reports/"
output_dir = "#{base_dir}/output/html/"
pdf_dir = "#{base_dir}/output/pdf/"

stu = Student.find("#{params[:mongo_id]}")
student_var = StudentVar.new(stu.id)
report = ReportCard.new(student_var, template_dir, output_dir)
redirect to("/admin")
end
