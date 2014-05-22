


# Here is the studentvar class where most of the
# work is done. When a new student is created
# the csv files are queried for all the values
# associated with that student for this quarter.
# Instances of the student class are created by
# specifing the student by their id.
class StudentVar
    def doublespacer(comment)
        doubled = Lingua::EN::Sentence.sentences(comment).join("&nbsp; ")
        doubled
    end
require 'lingua'
include Doublespacer
#include Mongoid::Document
  attr_reader \
    :id,             :year,             :signing_date,     :birthdate,        :name,             :lev,                     \
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
  def initialize(id, options={})
    defaults = {
        :gp => GradingPeriodPersist.all[0].grading_period.id.to_s
    }
    options = defaults.merge(options)
    @id                        = id
    student                    = Student.find(id)
    skill_track                = student.skill_tracks.find_by(:grading_period => options[:gp])
    grading_period             = GradingPeriodPersist.all[0].grading_period
    @year                      = grading_period.year
    @signing_date              = grading_period.signing_date.strftime("%B %e, %Y")
    @birthdate                 = student.dob.strftime("%B %e, %Y")
    @name                      = student.name
    @lev                       = skill_track.student_level
    #
    @art                       = Subject.find_by(:subject_id => "art").name
    @citizenship               = Subject.find_by(:subject_id => "citizenship").name
    @ict                       = Subject.find_by(:subject_id => "ict").name
    @language_arts             = Subject.find_by(:subject_id => "language_arts").name
    @math                      = Subject.find_by(:subject_id => "math").name
    @music                     = Subject.find_by(:subject_id => "music").name
    @pe                        = Subject.find_by(:subject_id => "pe").name
    @science                   = Subject.find_by(:subject_id => "science").name
    @social_studies            = Subject.find_by(:subject_id => "social_studies").name
    @thai                      = Subject.find_by(:subject_id => "thai").name
    @work_study                = Subject.find_by(:subject_id => "work_study").name
    #
    @art_t                     = Teacher.find(skill_track.art_teacher).name
    @citizenship_t             = Teacher.find(skill_track.citizenship_teacher).name
    @ict_t                     = Teacher.find(skill_track.ict_teacher).name
    @language_arts_t           = Teacher.find(skill_track.language_arts_teacher).name
    @math_t                    = Teacher.find(skill_track.math_teacher).name
    @music_t                   = Teacher.find(skill_track.music_teacher).name
    @pe_t                      = Teacher.find(skill_track.pe_teacher).name
    @science_t                 = Teacher.find(skill_track.science_teacher).name
    @social_studies_t          = Teacher.find(skill_track.social_studies_teacher).name
    @thai_t                    = Teacher.find(skill_track.thai_teacher).name
    @work_study_t              = Teacher.find(skill_track.work_study_teacher).name
    #
    @art_l                     = skill_track.art_level
    @citizenship_l             = skill_track.citizenship_level
    @ict_l                     = skill_track.ict_level
    @language_arts_l           = skill_track.language_arts_level
    @math_l                    = skill_track.math_level
    @music_l                   = skill_track.music_level
    @pe_l                      = skill_track.pe_level
    @science_l                 = skill_track.science_level
    @social_studies_l          = skill_track.social_studies_level
    @student_l                 = skill_track.student_level
    @thai_l                    = skill_track.thai_level
    @work_study_l              = skill_track.work_study_level
    #
    art_c                     = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "art").id).commentos[-1]
    citizenship_c             = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "citizenship").id).commentos[-1]
    ict_c                     = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "ict").id).commentos[-1]
    language_arts_c           = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "language_arts").id).commentos[-1]
    math_c                    = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "math").id).commentos[-1]
    music_c                   = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "music").id).commentos[-1]
    pe_c                      = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "pe").id).commentos[-1]
    science_c                 = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "science").id).commentos[-1]
    social_studies_c          = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "social_studies").id).commentos[-1]
    thai_c                    = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "thai").id).commentos[-1]
    work_study_c              = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "work_study").id).commentos[-1]
    @art_c                     =  art_c                    ? doublespacer(art_c.texto)              : "" 
    @citizenship_c             =  citizenship_c            ? doublespacer(citizenship_c.texto)      : "" 
    @ict_c                     =  ict_c                    ? doublespacer(ict_c.texto)              : "" 
    @language_arts_c           =  language_arts_c          ? doublespacer(language_arts_c.texto)    : "" 
    @math_c                    =  math_c                   ? doublespacer(math_c.texto)             : "" 
    @music_c                   =  music_c                  ? doublespacer(music_c.texto)            : "" 
    @pe_c                      =  pe_c                     ? doublespacer(pe_c.texto)               : "" 
    @science_c                 =  science_c                ? doublespacer(science_c.texto)          : "" 
    @social_studies_c          =  social_studies_c         ? doublespacer(social_studies_c.texto)   : "" 
    @thai_c                    =  thai_c                   ? doublespacer(thai_c.texto)             : "" 
    @work_study_c              =  work_study_c             ? doublespacer(work_study_c.texto)       : "" 
    #
    #
    language_arts_outcome_set  = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "language_arts").id}")
    language_arts_outcomes     = language_arts_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @language_arts_o_g_pairs   = language_arts_outcomes.map {|out| [out.texto, out.grade]}

    math_outcome_set           = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "math").id}")
    math_outcomes              = math_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @math_o_g_pairs            = math_outcomes.map {|out| [out.texto, out.grade]}

    social_studies_outcome_set = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "social_studies").id}")
    social_studies_outcomes    = social_studies_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @social_studies_o_g_pairs  = social_studies_outcomes.map {|out| [out.texto, out.grade]}

    science_outcome_set        = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "science").id}")
    science_outcomes           = science_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @science_o_g_pairs         = science_outcomes.map {|out| [out.texto, out.grade]}

    work_study_outcome_set     = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "work_study").id}")
    work_study_outcomes        = work_study_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @work_study_o_g_pairs      = work_study_outcomes.map {|out| [out.texto, out.grade]}

    citizenship_outcome_set    = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "citizenship").id}")
    citizenship_outcomes       = citizenship_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @citizenship_o_g_pairs     = citizenship_outcomes.map {|out| [out.texto, out.grade]}

    art_outcome_set            = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "art").id}")
    art_outcomes               = art_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @art_o_g_pairs             = art_outcomes.map {|out| [out.texto, out.grade]}

    ict_outcome_set            = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "ict").id}")
    ict_outcomes               = ict_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @ict_o_g_pairs             = ict_outcomes.map {|out| [out.texto, out.grade]}

    music_outcome_set          = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "music").id}")
    music_outcomes             = music_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @music_o_g_pairs           = music_outcomes.map {|out| [out.texto, out.grade]}

    pe_outcome_set             = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "pe").id}")
    pe_outcomes                = pe_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @pe_o_g_pairs              = pe_outcomes.map {|out| [out.texto, out.grade]}

    thai_outcome_set           = skill_track.outcome_sets.find_by(:subject_id => "#{Subject.find_by(:subject_id => "thai").id}")
    thai_outcomes              = thai_outcome_set.outcomes.sort_by {|obj| obj.indexo}
    @thai_o_g_pairs            = thai_outcomes.map {|out| [out.texto, out.grade]}
    #
    @q1days                    = student.attendance_set.q1_days
    @q2days                    = student.attendance_set.q2_days
    @q3days                    = student.attendance_set.q3_days
    @q4days                    = student.attendance_set.q4_days
    #
    @q1abs                     = student.attendance_set.q1_absence
    @q2abs                     = student.attendance_set.q2_absence
    @q3abs                     = student.attendance_set.q3_absence
    @q4abs                     = student.attendance_set.q4_absence
    #
    @q1tards                   = student.attendance_set.q1_tardy
    @q2tards                   = student.attendance_set.q2_tardy
    @q3tards                   = student.attendance_set.q3_tardy
    @q4tards                   = student.attendance_set.q4_tardy
    #
    @classroom_t               = Teacher.find(skill_track.teacher).name


  end
end