get "/admin/blast" do
# begin insanity
require 'rubygems'
require 'haml'
require 'csv'

# Set up the directories all relative to 'base_dir'
base_dir = "/Users/localadmin/Dropbox/RMA/"
csv_dir = "#{base_dir}csv_files/"
grade_dir = "#{csv_dir}grades/"
outcome_dir = "#{csv_dir}outcomes/"
comment_dir = "#{csv_dir}comments/"
template_dir = "#{base_dir}templates/"
output_dir = "#{base_dir}html_output"
js_dir = "#{output_dir}js/"
pdf_dir = "#{base_dir}pdf_output/"

# Here is the student class where most of the 
# work is done. When a new student is created
# the csv files are queried for all the values
# associated with that student for this quarter.
# Instances of the student class are created by
# specifing the student by their id.
class StudentVar
  attr_reader \
    :id,             :year,             :period,           :signing_date,     :birthdate,        :name,             :lev,                     \
    :art,            :art_t,            :art_l,            :art_o,            :art_g,            :art_c,            :art_o_g_pairs,           \
    :citizenship,    :citizenship_t,    :citizenship_l,    :citizenship_o,    :citizenship_g,    :citizenship_c,    :citizenship_o_g_pairs,   \
    :ict,            :ict_t,            :ict_l,            :ict_o,            :ict_g,            :ict_c,            :ict_o_g_pairs,           \
    :language_arts,  :language_arts_t,  :language_arts_l,  :language_arts_o,  :language_arts_g,  :language_arts_c,  :language_arts_o_g_pairs, \
    :math,           :math_t,           :math_l,           :math_o,           :math_g,           :math_c,           :math_o_g_pairs,          \
    :music,          :music_t,          :music_l,          :music_o,          :music_g,          :music_c,          :music_o_g_pairs,         \
    :pe,             :pe_t,             :pe_l,             :pe_o,             :pe_g,             :pe_c,             :pe_o_g_pairs,            \
    :science,        :science_t,        :science_l,        :science_o,        :science_g,        :science_c,        :science_o_g_pairs,       \
    :social_studies, :social_studies_t, :social_studies_l, :social_studies_o, :social_studies_g, :social_studies_c, :social_studies_o_g_pairs,\
    :thai,           :thai_t,           :thai_l,           :thai_o,           :thai_g,           :thai_c,           :thai_o_g_pairs,          \
    :work_study,     :work_study_t,     :work_study_l,     :work_study_o,     :work_study_g,     :work_study_c,     :work_study_o_g_pairs,    \
    :q1days,         :q2days,           :q3days,           :q4days,                                                                           \
    :q1abs,          :q2abs,            :q3abs,            :q4abs,                                                                            \
    :q1tards,        :q2tards,          :q3tards,          :q4tards,                                                                          \
    :classroom_t                                                                    
  def initialize(id)
    @id = id
    @year = self.grading_period_info["year"]
    @period = self.grading_period_info["period"]
    @signing_date = self.grading_period_info["signing_date"]
    @birthdate = self.dob[id]
    @name = self.student[id]
    @lev = self.level[self.student_level[id]]
    
    @art = subject_list["art"]
    @citizenship = subject_list["citizenship"]
    @ict = subject_list["ict"]
    @language_arts = subject_list["language_arts"]
    @math = subject_list["math"]
    @music = subject_list["music"]
    @pe = subject_list["pe"]
    @science = subject_list["science"]
    @social_studies = subject_list["social_studies"]
    @thai = subject_list["thai"]
    @work_study = subject_list["work_study"]
    
    @art_t = self.teacher[self.art_teacher[id]]
    @citizenship_t = self.teacher[self.citizenship_teacher[id]]
    @ict_t = self.teacher[self.ict_teacher[id]]
    @language_arts_t = self.teacher[self.language_arts_teacher[id]]
    @math_t = self.teacher[self.math_teacher[id]]
    @music_t = self.teacher[self.music_teacher[id]]
    @pe_t = self.teacher[self.pe_teacher[id]]
    @science_t = self.teacher[self.science_teacher[id]]
    @social_studies_t = self.teacher[self.social_studies_teacher[id]]
    @thai_t = self.teacher[self.thai_teacher[id]]
    @work_study_t = self.teacher[self.work_study_teacher[id]]
    
    @art_l = self.art_level[id]
    @citizenship_l = self.citizenship_level[id]
    @ict_l = self.ict_level[id]
    @language_arts_l = self.language_arts_level[id]
    @math_l = self.math_level[id]
    @music_l = self.music_level[id]
    @pe_l = self.pe_level[id]
    @science_l = self.science_level[id]
    @social_studies_l = self.social_studies_level[id]
    @student_l = self.student_level[id]
    @thai_l = self.thai_level[id]
    @work_study_l = self.work_study_level[id]
    
    @art_c = self.art_comments[id]
    @citizenship_c = self.citizenship_comments[id]
    @ict_c = self.ict_comments[id]
    @language_arts_c = self.language_arts_comments[id]
    @math_c = self.math_comments[id]
    @music_c = self.music_comments[id]
    @pe_c = self.pe_comments[id]
    @science_c = self.science_comments[id]
    @social_studies_c = self.social_studies_comments[id]
    @thai_c = self.thai_comments[id]
    @work_study_c = self.work_study_comments[id]
    

    @art_o_g_pairs = []
    @art_o_g_pairs = @art_o.zip(art_g)

    @citizenship_o_g_pairs = []
    @citizenship_o_g_pairs = @citizenship_o.zip(citizenship_g)

    @ict_o_g_pairs = []
    @ict_o_g_pairs = @ict_o.zip(ict_g)

    @language_arts_o_g_pairs = []
    @language_arts_o_g_pairs = @language_arts_o.zip(language_arts_g)

    @math_o_g_pairs = []
    @math_o_g_pairs = @math_o.zip(math_g)

    @music_o_g_pairs = []
    @music_o_g_pairs = @music_o.zip(music_g)

    @pe_o_g_pairs = []
    @pe_o_g_pairs = @pe_o.zip(pe_g)

    @science_o_g_pairs = []
    @science_o_g_pairs = @science_o.zip(science_g)

    @social_studies_o_g_pairs = []
    @social_studies_o_g_pairs = @social_studies_o.zip(social_studies_g)

    @thai_o_g_pairs = []
    @thai_o_g_pairs = @thai_o.zip(thai_g)

    @work_study_o_g_pairs = []
    @work_study_o_g_pairs = @work_study_o.zip(work_study_g)
    
    @q1days = self.grading_period_info["q1_num_days"]
    @q2days = self.grading_period_info["q2_num_days"]
    @q3days = self.grading_period_info["q3_num_days"]
    @q4days = self.grading_period_info["q4_num_days"]
    
    @q1abs = self.q1_absences[id]
    @q2abs = self.q2_absences[id]
    @q3abs = self.q3_absences[id]
    @q4abs = self.q4_absences[id]

    @q1tards = self.q1_tardies[id]
    @q2tards = self.q2_tardies[id]
    @q3tards = self.q3_tardies[id]
    @q4tards = self.q4_tardies[id]
    
    class_rm_teacher_id = self.classroom_teacher[id]
    @classroom_t = self.teacher["#{class_rm_teacher_id}"]
    
  end
end



# Variables that are available within the scope
# of an instance of this class can be used in 
# the report card haml template
class ReportCard
  def initialize(student_obj, template_path, output_path)
    @student = student_obj
    @template_path = template_path
    report_card = File.read("#{template_path}report_card.html.haml")
    haml_engine = Haml::Engine.new(report_card)
    output = haml_engine.render(scope = self, locals = {})
    File.open("#{output_path}REPORT_CARD_#{student_obj.id}.html", 'w') { |f| f.write(output) }
    #puts output
  end
end



# This method is called from within the report card
# template to render subtemplates for different subjects
# based on what level the student has for that subject.
def render_file(path, filename)
  contents = File.read("#{path}#{filename}")
  Haml::Engine.new(contents).render(scope = self, locals = {})
end


   student = StudentVar.new(id)
   report = ReportCard.new(student, template_dir, output_dir)

# end insanity
redirect to("/admin")
end
