
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

# Subfolders
folders = ["attendance", "info", "levels", "teachers"]

# Go through subfolders creating pairs of [filename, path]
# Each of these will be used to create a method that
# pulls data from the .csv file at that location
csv_pairs = []
folders.each do |folder|
  Dir.glob("#{csv_dir}#{folder}/*.csv") do |name|
    full_path = name.downcase
    name.slice!("#{csv_dir}#{folder}/")
    name.slice!(".csv")
    csv_pairs << [name, full_path]
  end
end

# Comments, grades and outcomes need special handling
# so they go in their own variables
comment_pairs = []
Dir.glob("#{comment_dir}*.csv") do |name|
  full_path = name.downcase
  name.slice!("#{comment_dir}")
  name.slice!(".csv")
  comment_pairs << [name, full_path]
end

grade_pairs = []
Dir.glob("#{grade_dir}*.csv") do |name|
  full_path = name.downcase
  name.slice!("#{grade_dir}")
  name.slice!(".csv")
  grade_pairs << [name, full_path]
end

outcome_pairs_12 = []
Dir.glob("#{outcome_dir}L12/*.csv") do |name|
  full_path = name.downcase
  name.slice!("#{outcome_dir}L12/")
  name.slice!(".csv")
  outcome_pairs_12 << [name, full_path]
end

outcome_pairs_34 = []
Dir.glob("#{outcome_dir}L34/*.csv") do |name|
  full_path = name.downcase
  name.slice!("#{outcome_dir}L34/")
  name.slice!(".csv")
  outcome_pairs_34 << [name, full_path]
end

outcome_pairs_56 = []
Dir.glob("#{outcome_dir}L56/*.csv") do |name|
  full_path = name.downcase
  name.slice!("#{outcome_dir}L56/")
  name.slice!(".csv")
  outcome_pairs_56 << [name, full_path]
end

outcome_pairs_78 = []
Dir.glob("#{outcome_dir}L78/*.csv") do |name|
  full_path = name.downcase
  name.slice!("#{outcome_dir}L78/")
  name.slice!(".csv")
  outcome_pairs_78 << [name, full_path]
end

# Uncomment the following lines to take a gander
# at the csv_file, path_to_csv_file nested arrays
#
# puts csv_pairs.inspect
# puts
# puts comment_pairs.inspect
# puts
# puts grade_pairs.inspect
# puts
# puts outcome_pairs_12.inspect
# puts
# puts outcome_pairs_34.inspect
# puts
# puts outcome_pairs_56.inspect
# puts
# puts outcome_pairs_78.inspect

# Here is the student class where most of the
# work is done. When a new student is created
# the csv files are queried for all the values
# associated with that student for this quarter.
# Instances of the student class are created by
# specifing the student by their id.
class Student
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

    outs = Outcomes.new(@name, @art_l, @citizenship_l, @ict_l, @language_arts_l, \
      @math_l, @music_l, @pe_l, @science_l, @social_studies_l, @student_l, @thai_l, @work_study_l)

    @art_o = outs.art_o
    @art_g = [nil]
    unless self.art_grades[id] == nil
      @art_g = self.art_grades[id].split(/ *,/)
      @art_g = @art_g.each { |g| g.strip! }
    end
    @art_o_g_pairs = []
    @art_o_g_pairs = @art_o.zip(art_g)

    @citizenship_o = outs.citizenship_o
    @citizenship_g = [nil]
    unless self.citizenship_grades[id] == nil
      @citizenship_g = self.citizenship_grades[id].split(/ *,/)
      @citizenship_g = @citizenship_g.each { |g| g.strip! }
    end
    @citizenship_o_g_pairs = []
    @citizenship_o_g_pairs = @citizenship_o.zip(citizenship_g)

    @ict_o = outs.ict_o
    @ict_g = [nil]
    unless self.ict_grades[id] == nil
      @ict_g = self.ict_grades[id].split(/ *,/)
      @ict_g = @ict_g.each { |g| g.strip! }
    end
    @ict_o_g_pairs = []
    @ict_o_g_pairs = @ict_o.zip(ict_g)

    @language_arts_o = outs.language_arts_o
    @language_arts_g = [nil]
    unless self.language_arts_grades[id] == nil
      @language_arts_g = self.language_arts_grades[id].split(/ *,/)
      @language_arts_g = @language_arts_g.each { |g| g.strip! }
    end
    @language_arts_o_g_pairs = []
    @language_arts_o_g_pairs = @language_arts_o.zip(language_arts_g)

    @math_o = outs.math_o
    @math_g = [nil]
    unless self.math_grades[id] == nil
      @math_g = self.math_grades[id].split(/ *,/)
      @math_g = @math_g.each { |g| g.strip! }
    end
    @math_o_g_pairs = []
    @math_o_g_pairs = @math_o.zip(math_g)

    @music_o = outs.music_o
    @music_g = [nil]
    unless self.music_grades[id] == nil
      @music_g = self.music_grades[id].split(/ *,/)
      @music_g = @music_g.each { |g| g.strip! }
    end
    @music_o_g_pairs = []
    @music_o_g_pairs = @music_o.zip(music_g)

    @pe_o = outs.pe_o
    @pe_g = [nil]
    unless self.pe_grades[id] == nil
      @pe_g = self.pe_grades[id].split(/ *,/)
      @pe_g = @pe_g.each { |g| g.strip! }
    end
    @pe_o_g_pairs = []
    @pe_o_g_pairs = @pe_o.zip(pe_g)

    @science_o = outs.science_o
    @science_g = [nil]
    unless self.science_grades[id] == nil
      @science_g = self.science_grades[id].split(/ *,/)
      @science_g = @science_g.each { |g| g.strip! }
    end
    @science_o_g_pairs = []
    @science_o_g_pairs = @science_o.zip(science_g)

    @social_studies_o = outs.social_studies_o
    @social_studies_g = [nil]
    unless self.social_studies_grades[id] == nil
      @social_studies_g = self.social_studies_grades[id].split(/ *,/)
      @social_studies_g = @social_studies_g.each { |g| g.strip! }
    end
    @social_studies_o_g_pairs = []
    @social_studies_o_g_pairs = @social_studies_o.zip(social_studies_g)

    @thai_o = outs.thai_o
    @thai_g = [nil]
    unless self.thai_grades[id] == nil
      @thai_g = self.thai_grades[id].split(/ *,/)
      @thai_g = @thai_g.each { |g| g.strip! }
    end
    @thai_o_g_pairs = []
    @thai_o_g_pairs = @thai_o.zip(thai_g)

    @work_study_o = outs.work_study_o
    @work_study_g = [nil]
    unless self.work_study_grades[id] == nil
      @work_study_g = self.work_study_grades[id].split(/ *,/)
      @work_study_g = @work_study_g.each { |g| g.strip! }
    end
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

Student.class_eval do
  csv_pairs.each do |name|
    define_method("#{name[0]}") do
      var = {}
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        key   = line[0]
        value = line[1]
        var.merge!(key => value)
      end
      var.shift
      var
    end
  end
  comment_pairs.each do |name|
    define_method("#{name[0]}") do
      var = {}
      CSV.foreach("#{name[1]}", :row_sep => :auto, :col_sep => "\t", :quote_char => "#") do |line|
        key   = line[0]
        value = line[1]
        var.merge!(key => value)
      end
      var.shift
      var
    end
  end
  grade_pairs.each do |name|
    define_method("#{name[0]}") do
      var = {}
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        key   = line[0]
        value = line[1]
        var.merge!(key => value)
      end
      var.shift
      var
    end
  end
end

class Outcomes
  attr_reader :art_o, :citizenship_o, :ict_o, :language_arts_o, :math_o, :music_o, :pe_o, :science_o, :social_studies_o, :student_o, :thai_o, :work_study_o
  def initialize(student, art_l, citizenship_l, ict_l, language_arts_l, math_l, music_l, pe_l, science_l, social_studies_l, student_l, thai_l, work_study_l)

    if art_l == "L12"
      @art_o = self.art_outcomes_12
    elsif art_l == "L34"
      @art_o = self.art_outcomes_34
    elsif art_l == "L56"
      @art_o = self.art_outcomes_56
    elsif art_l == "L78"
      @art_o = self.art_outcomes_78
    else
      raise "Art level not entered for #{student}."
    end

    if citizenship_l == "L12"
      @citizenship_o = self.citizenship_outcomes_12
    elsif citizenship_l == "L34"
      @citizenship_o = self.citizenship_outcomes_34
    elsif citizenship_l == "L56"
      @citizenship_o = self.citizenship_outcomes_56
    elsif citizenship_l == "L78"
      @citizenship_o = self.citizenship_outcomes_78
    else
      raise "Citizenship level not entered for #{student}."
    end

    if ict_l == "L12"
      @ict_o = self.ict_outcomes_12
    elsif ict_l == "L34"
      @ict_o = self.ict_outcomes_34
    elsif ict_l == "L56"
      @ict_o = self.ict_outcomes_56
    elsif ict_l == "L78"
      @ict_o = self.ict_outcomes_78
    else
      raise "I.C.T. level not entered for #{student}."
    end

    if language_arts_l == "L12"
      @language_arts_o = self.language_arts_outcomes_12
    elsif language_arts_l == "L34"
      @language_arts_o = self.language_arts_outcomes_34
    elsif language_arts_l == "L56"
      @language_arts_o = self.language_arts_outcomes_56
    elsif language_arts_l == "L78"
      @language_arts_o = self.language_arts_outcomes_78
    else
      raise "Language Arts level not entered for #{student}."
    end

    if math_l == "L12"
      @math_o = self.math_outcomes_12
    elsif math_l == "L34"
      @math_o = self.math_outcomes_34
    elsif math_l == "L56"
      @math_o = self.math_outcomes_56
    elsif math_l == "L78"
      @math_o = self.math_outcomes_78
    else
      raise "Math level not entered for #{student}."
    end

    if music_l == "L12"
      @music_o = self.music_outcomes_12
    elsif music_l == "L34"
      @music_o = self.music_outcomes_34
    elsif music_l == "L56"
      @music_o = self.music_outcomes_56
    elsif music_l == "L78"
      @music_o = self.music_outcomes_78
    else
      raise "Music level not entered for #{student}."
    end

    if pe_l == "L12"
      @pe_o = self.pe_outcomes_12
    elsif pe_l == "L34"
      @pe_o = self.pe_outcomes_34
    elsif pe_l == "L56"
      @pe_o = self.pe_outcomes_56
    elsif pe_l == "L78"
      @pe_o = self.pe_outcomes_78
    else
      raise "P.E. level not entered for #{student}."
    end

    if science_l == "L12"
      @science_o = self.science_outcomes_12
    elsif science_l == "L34"
      @science_o = self.science_outcomes_34
    elsif science_l == "L56"
      @science_o = self.science_outcomes_56
    elsif science_l == "L78"
      @science_o = self.science_outcomes_78
    else
      raise "Science level not entered for #{student}."
    end

    if social_studies_l == "L12"
      @social_studies_o = self.social_studies_outcomes_12
    elsif social_studies_l == "L34"
      @social_studies_o = self.social_studies_outcomes_34
    elsif social_studies_l == "L56"
      @social_studies_o = self.social_studies_outcomes_56
    elsif social_studies_l == "L78"
      @social_studies_o = self.social_studies_outcomes_78
    else
      raise "Level not entered for #{student}."
    end

    if thai_l == "L12"
      @thai_o = self.thai_outcomes_12
    elsif thai_l == "L34"
      @thai_o = self.thai_outcomes_34
    elsif thai_l == "L56"
      @thai_o = self.thai_outcomes_56
    elsif thai_l == "L78"
      @thai_o = self.thai_outcomes_78
    else
      raise "Thai level not entered for #{student}."
    end

    if work_study_l == "L12"
      @work_study_o = self.work_study_outcomes_12
    elsif work_study_l == "L34"
      @work_study_o = self.work_study_outcomes_34
    elsif work_study_l == "L56"
      @work_study_o = self.work_study_outcomes_56
    elsif work_study_l == "L78"
      @work_study_o = self.work_study_outcomes_78
    else
      raise "Work Study level not entered for #{student}."
    end

  end
end

Outcomes.class_eval do
  outcome_pairs_12.each do |name|
    define_method("#{name[0]}_12") do
      var = []
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        var << line[0]
      end
      var.shift
      var
    end
  end

  outcome_pairs_34.each do |name|
    define_method("#{name[0]}_34") do
      var = []
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        var << line[0]
      end
      var.shift
      var
    end
  end

  outcome_pairs_56.each do |name|
    define_method("#{name[0]}_56") do
      var = []
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        var << line[0]
      end
      var.shift
      var
    end
  end

  outcome_pairs_78.each do |name|
    define_method("#{name[0]}_78") do
      var = []
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        var << line[0]
      end
      var.shift
      var
    end
  end
end

# Variables that are available within the scope
# of an instance of this class can be used in
# haml templates
class ReportCard
  def initialize(student_obj, template_path, output_path)
    @student = student_obj
    @template_path = template_path
    report_card = File.read("#{template_path}report_card.html.haml")
    haml_engine = Haml::Engine.new(report_card)
    output = haml_engine.render(scope = self, locals = {})
    File.open("#{output_path}REPORT_CARD_#{student_obj.id}.html", 'w') { |f| f.write(output) }
    puts output
  end
end

class LandingPage
  def initialize(student_list, template_path, output_path)
    triplets = []
    row = []
    count = 0
    student_list.each do |stu|
      count += 1
      row << stu
      if count == 3
        copy = Array.new(row)
        triplets.push(copy)
        count = 0
        row.clear
      end
    end
    @students = triplets
    @template_path = template_path
    @output_path = "http://localhost/~localadmin/"
    landing_page = File.read("#{template_path}landing_page.html.haml")
    haml_engine = Haml::Engine.new(landing_page)
    output = haml_engine.render(scope = self, locals = {})
    File.open("#{output_path}LANDING_PAGE.html", 'w') { |f| f.write(output) }
    #puts output
  end
end

class DataIntegrity
  attr_reader :q1_absences_ok, :q1_tardies_ok, :q2_absences_ok, :q2_tardies_ok, :q3_absences_ok, :q3_tardies_ok, :q4_absences_ok, :q4_tardies_ok, :dob_ok, :level_ok, :art_level_ok, :citizenship_level_ok, :ict_level_ok, :language_arts_level_ok, :math_level_ok, :music_level_ok, :pe_level_ok, :science_level_ok, :social_studies_level_ok, :student_level_ok, :thai_level_ok, :work_study_level_ok, :art_teacher_ok, :citizenship_teacher_ok, :classroom_teacher_ok, :ict_teacher_ok, :language_arts_teacher_ok, :math_teacher_ok, :music_teacher_ok, :pe_teacher_ok, :science_teacher_ok, :social_studies_teacher_ok, :student_grade_level_teacher_ok, :thai_teacher_ok, :work_study_teacher_ok
  def initialize(student_list, teacher_list, quarters, template_path, output_path)
    #@student_objects = []
    # students.each do |id|
    #   student = Student.new(id)
    #   @student_objects << student
    # end
    @error_count = 0
    student_list.compact!
    if student_list.compact.uniq.length == student_list.compact.length
      @uniq_std_ids = "ok"
    else
      dups = student_list.select{|item| student_list.count(item) > 1}.uniq #http://stackoverflow.com/questions/8921999/ruby-how-to-find-and-return-a-duplicate-value-in-array
      @uniq_std_ids = "There are #{ student_list.compact.length - student_list.uniq.compact.length } duplicates in the student list. Please look at: #{dups.inspect}"
      @error_count += 1
    end


    if self.q1_absences.compact.sort == student_list.compact.sort
      @q1_absences_ok = "ok"
    else
      extra   = self.q1_absences - student_list
      missing = student_list - self.q1_absences
      @q1_absences_ok = "q1_absences.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q1_tardies.compact.sort == student_list.compact.sort
      @q1_tardies_ok = "ok"
    else
      extra   = self.q1_tardies - student_list
      missing = student_list - self.q1_tardies
      @q1_tardies_ok = "q1_tardies.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q2_absences.compact.sort == student_list.compact.sort
      @q2_absences_ok = "ok"
    else
      extra   = self.q2_absences - student_list
      missing = student_list - self.q2_absences
      @q2_absences_ok = "q2_absences.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q2_tardies.compact.sort == student_list.compact.sort
      @q2_tardies_ok = "ok"
    else
      extra   = self.q2_tardies - student_list
      missing = student_list - self.q2_tardies
      @q2_tardies_ok = "q2_tardies.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q3_absences.compact.sort == student_list.compact.sort
      @q3_absences_ok = "ok"
    else
      extra   = self.q3_absences - student_list
      missing = student_list - self.q3_absences
      @q3_absences_ok = "q3_absences.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q3_tardies.compact.sort == student_list.compact.sort
      @q3_tardies_ok = "ok"
    else
      extra   = self.q3_tardies - student_list
      missing = student_list - self.q3_tardies
      @q3_tardies_ok = "q3_tardies.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q4_absences.compact.sort == student_list.compact.sort
      @q4_absences_ok = "ok"
    else
      extra   = self.q4_absences - student_list
      missing = student_list - self.q4_absences
      @q4_absences_ok = "q4_absences.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.q4_tardies.compact.sort == student_list.compact.sort
      @q4_tardies_ok = "ok"
    else
      extra   = self.q4_tardies - student_list
      missing = student_list - self.q4_tardies
      @q4_tardies_ok = "q4_tardies.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.dob.compact.sort == student_list.compact.sort
      @dob_ok = "ok"
    else
      extra   = self.dob - student_list
      missing = student_list - self.dob
      @dob_ok = "dob.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.art_level.compact.sort == student_list.compact.sort
      @art_level_ok = "ok"
    else
      extra   = self.art_level - student_list
      missing = student_list - self.art_level
      @art_level_ok = "art_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.citizenship_level.compact.sort == student_list.compact.sort
      @citizenship_level_ok = "ok"
    else
      extra   = self.citizenship_level - student_list
      missing = student_list - self.citizenship_level
      @citizenship_level_ok = "citizenship_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.ict_level.compact.sort == student_list.compact.sort
      @ict_level_ok = "ok"
    else
      extra   = self.ict_level - student_list
      missing = student_list - self.ict_level
      @ict_level_ok = "ict_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.language_arts_level.compact.sort == student_list.compact.sort
      @language_arts_level_ok = "ok"
    else
      extra   = self.language_arts_level - student_list
      missing = student_list - self.language_arts_level
      @language_arts_level_ok = "language_arts_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.math_level.compact.sort == student_list.compact.sort
      @math_level_ok = "ok"
    else
      extra   = self.math_level - student_list
      missing = student_list - self.math_level
      @math_level_ok = "math_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.music_level.compact.sort == student_list.compact.sort
      @music_level_ok = "ok"
    else
      extra   = self.music_level - student_list
      missing = student_list - self.music_level
      @music_level_ok = "music_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.pe_level.compact.sort == student_list.compact.sort
      @pe_level_ok = "ok"
    else
      extra   = self.pe_level - student_list
      missing = student_list - self.pe_level
      @pe_level_ok = "pe_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.science_level.compact.sort == student_list.compact.sort
      @science_level_ok = "ok"
    else
      extra   = self.science_level - student_list
      missing = student_list - self.science_level
      @science_level_ok = "science_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.social_studies_level.compact.sort == student_list.compact.sort
      @social_studies_level_ok = "ok"
    else
      extra   = self.social_studies_level - student_list
      missing = student_list - self.social_studies_level
      @social_studies_level_ok = "social_studies_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.student_level.compact.sort == student_list.compact.sort
      @student_level_ok = "ok"
    else
      extra   = self.student_level - student_list
      missing = student_list - self.student_level
      @student_level_ok = "student_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.thai_level.compact.sort == student_list.compact.sort
      @thai_level_ok = "ok"
    else
      extra   = self.thai_level - student_list
      missing = student_list - self.thai_level
      @thai_level_ok = "thai_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.work_study_level.compact.sort == student_list.compact.sort
      @work_study_level_ok = "ok"
    else
      extra   = self.work_study_level - student_list
      missing = student_list - self.work_study_level
      @work_study_level_ok = "work_study_level.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.art_teacher.compact.sort == student_list.compact.sort
      @art_teacher_ok = "ok"
    else
      extra   = self.art_teacher - student_list
      missing = student_list - self.art_teacher
      @art_teacher_ok = "art_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.citizenship_teacher.compact.sort == student_list.compact.sort
      @citizenship_teacher_ok = "ok"
    else
      extra   = self.citizenship_teacher - student_list
      missing = student_list - self.citizenship_teacher
      @citizenship_teacher_ok = "citizenship_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.classroom_teacher.compact.sort == student_list.compact.sort
      @classroom_teacher_ok = "ok"
    else
      extra   = self.classroom_teacher - student_list
      missing = student_list - self.classroom_teacher
      @classroom_teacher_ok = "classroom_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.ict_teacher.compact.sort == student_list.compact.sort
      @ict_teacher_ok = "ok"
    else
      extra   = self.ict_teacher - student_list
      missing = student_list - self.ict_teacher
      @ict_teacher_ok = "ict_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.language_arts_teacher.compact.sort == student_list.compact.sort
      @language_arts_teacher_ok = "ok"
    else
      extra   = self.language_arts_teacher - student_list
      missing = student_list - self.language_arts_teacher
      @language_arts_teacher_ok = "language_arts_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.math_teacher.compact.sort == student_list.compact.sort
      @math_teacher_ok = "ok"
    else
      extra   = self.math_teacher - student_list
      missing = student_list - self.math_teacher
      @math_teacher_ok = "math_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.music_teacher.compact.sort == student_list.compact.sort
      @music_teacher_ok = "ok"
    else
      extra   = self.music_teacher - student_list
      missing = student_list - self.music_teacher
      @music_teacher_ok = "music_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.pe_teacher.compact.sort == student_list.compact.sort
      @pe_teacher_ok = "ok"
    else
      extra   = self.pe_teacher - student_list
      missing = student_list - self.pe_teacher
      @pe_teacher_ok = "pe_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.science_teacher.compact.sort == student_list.compact.sort
      @science_teacher_ok = "ok"
    else
      extra   = self.science_teacher - student_list
      missing = student_list - self.science_teacher
      @science_teacher_ok = "science_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.social_studies_teacher.compact.sort == student_list.compact.sort
      @social_studies_teacher_ok = "ok"
    else
      extra   = self.social_studies_teacher - student_list
      missing = student_list - self.social_studies_teacher
      @social_studies_teacher_ok = "social_studies_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.student_grade_level_teacher.compact.sort == student_list.compact.sort
      @student_grade_level_teacher_ok = "ok"
    else
      extra   = self.student_grade_level_teacher - student_list
      missing = student_list - self.student_grade_level_teacher
      @student_grade_level_teacher_ok = "student_grade_level_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.thai_teacher.compact.sort == student_list.compact.sort
      @thai_teacher_ok = "ok"
    else
      extra   = self.thai_teacher - student_list
      missing = student_list - self.thai_teacher
      @thai_teacher_ok = "thai_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end

    if self.work_study_teacher.compact.sort == student_list.compact.sort
      @work_study_teacher_ok = "ok"
    else
      extra   = self.work_study_teacher - student_list
      missing = student_list - self.work_study_teacher
      @work_study_teacher_ok = "work_study_teacher.csv Extra students: #{extra}. Missing students: #{missing}"
      @error_count += 1
    end
    @error_count = @error_count.to_s


    p = self.methods - Object.methods
    puts p.inspect
    @pass_std_ids = "only all the time" #stub

    @template_path = template_path
    @output_path = "http://localhost/~localadmin/"
    data_integrity = File.read("#{template_path}data_integrity.html.haml")
    haml_engine = Haml::Engine.new(data_integrity)
    output = haml_engine.render(scope = self, locals = {})
    File.open("#{output_path}DATA_INTEGRITY.html", 'w') { |f| f.write(output) }
    #puts output
  end
end

DataIntegrity.class_eval do
  csv_pairs.each do |name|
    define_method("#{name[0]}") do
      var = []
      CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
        key   = line[0]
        var << key
      end
      var.shift
      var
    end
  end
  # comment_pairs.each do |name|
  #   define_method("#{name[0]}") do
  #     var = {}
  #     CSV.foreach("#{name[1]}", :row_sep => :auto, :col_sep => "\t", :quote_char => "#") do |line|
  #       key   = line[0]
  #       value = line[1]
  #       var.merge!(key => value)
  #     end
  #     var.shift
  #     var
  #   end
  # end
  # grade_pairs.each do |name|
  #   define_method("#{name[0]}") do
  #     var = {}
  #     CSV.foreach("#{name[1]}", {:col_sep=>"\t"}) do |line|
  #       key   = line[0]
  #       value = line[1]
  #       var.merge!(key => value)
  #     end
  #     var.shift
  #     var
  #   end
  # end
end

class Teacher
  attr_reader :language_arts_teacher
  def initialize(student_list, teacher_list)

    teacher_list.compact!
    no_language_arts_students = []
    teacher_list.each do |teacher|
      @language_arts_students = []

      student_list.compact!
      student_list.each do |id|
        student = Student.new(id)
        #puts teacher
        #puts student.language_arts_teacher[id]
        if student.language_arts_teacher[id] == teacher
          @language_arts_students << student.id
        end
      end

      if @language_arts_students.empty?
        no_language_arts_students << teacher
      else
        puts "#{teacher} has for Language Arts:"
        puts @language_arts_students.inspect
      end

    end
    puts "#{no_language_arts_students.inspect} have no Language Arts students"
  end
end



# This method is called from within the report card
# template to render subtemplates for different subjects
# based on what level the student has for that subject.
def render_file(path, filename)
  contents = File.read("#{path}#{filename}")
  Haml::Engine.new(contents).render(scope = self, locals = {})
end

students = []
CSV.foreach("#{csv_dir}info/student.csv", {:col_sep=>"\t"}) do |line|
  students << line[0]
end
students.shift

teachers = []
CSV.foreach("#{csv_dir}info/teacher.csv", {:col_sep=>"\t"}) do |line|
  teachers << line[0]
end
teachers.shift

a = Teacher.new(students, teachers)
#data = DataIntegrity.new(students, teachers, 4, template_dir, output_dir)
        #puts students.inspect
        #student = Student.new("mao_tsuji")

#        student = Student.new("athena_bailey")

        # There should now be an html file in the output folder.
        #report = ReportCard.new(student, template_dir, output_dir)

# students.each do |id|
#   student = Student.new(id)
#   report = ReportCard.new(student, template_dir, output_dir)
#   puts "Successfully created report for #{student.name}."
#   `mv #{output_dir}REPORT_CARD_#{student.id}.html /Users/localadmin/Sites/REPORT_CARD_#{student.id}.html`
# end
#
# LandingPage.new(students, template_dir, output_dir)

        #`/usr/local/bin/html2pdf --papersize=a4 #{output_dir}REPORT_CARD_#{student.id}.html`
        #`mv #{output_dir}REPORT_CARD_#{student.id}.html /Users/localadmin/Sites/REPORT_CARD_#{student.id}.html`
        #`mv #{output_dir}REPORT_CARD_#{student.id}.pdf #{pdf_dir}REPORT_CARD_#{student.id}.pdf`
        #`java tool.pdf.Impose -nup 2 -page 4,1,2,3 -paper A3 #{pdf_dir}REPORT_CARD_#{student.id}.pdf`
        #`mv #{pdf_dir}REPORT_CARD_#{student.id}-up.pdf #{pdf_dir}imposed/REPORT_CARD_#{student.id}-up.pdf`

# phantomjs phantomjs_script url file_name
#`open "/Applications/Google Chrome.app"  http://localhost/~localadmin/REPORT_CARD_athena_bailey `



#`mv #{output_dir}DATA_INTEGRITY.html /Users/localadmin/Sites/DATA_INTEGRITY.html`
#`open "/Applications/Google Chrome.app"  http://localhost/~localadmin/DATA_INTEGRITY.html `





# end insanity
redirect to("/admin")
end