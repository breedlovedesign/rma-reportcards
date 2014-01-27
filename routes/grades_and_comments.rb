# encoding: utf-8
	class String
		def paragraph_prep
			self.gsub!(/^[ \t]/, "")
			self.gsub!(/[ \t]$/, "")
			self.gsub!(/[ \t]{2,}/, " ")
			self.gsub!(/\r\n/, "\n")
			self.gsub!(/(\n\n|\r\n\r\n)/, '0129934')
			if self == nil
				raise "whitespace error"
			end
			return self
		end

		def paragraph_reinsertion
			self.gsub!(/0129934/, "\n\n")
		end
	end

get "/grading/:student_id" do
	teacher?
	@teacher = Teacher.find_by(:id => session[:teacher_id])
	@student = Student.find_by(:id => params[:student_id])
	@skill_track = @student.skill_tracks.find_by(:grading_period => $current_quarter)


	language_arts_id = Subject.find_by(:subject_id => "language_arts").id
	@language_arts_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => language_arts_id)


	math_id = Subject.find_by(:subject_id => "math").id
	@math_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => math_id)

	social_studies_id = Subject.find_by(:subject_id => "social_studies").id
	@social_studies_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => social_studies_id)

	science_id = Subject.find_by(:subject_id => "science").id
	@science_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => science_id)

	work_study_id = Subject.find_by(:subject_id => "work_study").id
	@work_study_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => work_study_id)

	citizenship_id = Subject.find_by(:subject_id => "citizenship").id
	@citizenship_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => citizenship_id)

	art_id = Subject.find_by(:subject_id => "art").id
	@art_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => art_id)

	ict_id = Subject.find_by(:subject_id => "ict").id
	@ict_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => ict_id)

	music_id = Subject.find_by(:subject_id => "music").id
	@music_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => music_id)

	pe_id = Subject.find_by(:subject_id => "pe").id
	@pe_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => pe_id)

	thai_id = Subject.find_by(:subject_id => "thai").id
	@thai_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => thai_id)

	haml :"grading/grading", :layout => :teacher_layout
end

get "/commenting/:student_id" do
	teacher?
	@teacher = Teacher.find_by(:id => session[:teacher_id])
	@student = Student.find_by(:id => params[:student_id])
	@skill_track = @student.skill_tracks.find_by(:grading_period => $current_quarter)
#########
	@student_var = StudentVar.new(@student.id)

#########
	language_arts_id = Subject.find_by(:subject_id => "language_arts").id
	@language_arts_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => language_arts_id)
	if  (@language_arts_outcome_set.commentos.nil? == false) && (@language_arts_outcome_set.commentos.length > 1)

		@language_arts_commentos = @language_arts_outcome_set.commentos
		@language_arts_current = @language_arts_commentos[-1].texto
		@language_arts_prior = @language_arts_commentos[-2].texto
		@language_arts_previous_comments = @language_arts_commentos[0..-3].map{ |comment| comment.texto}

		report_prior = Lingua::EN::Readability.new(@language_arts_prior)
		@language_arts_prior_sentence_count = report_prior.num_sentences
		@language_arts_prior_word_count = report_prior.num_words
		@language_arts_prior_character_count = @language_arts_prior.length

		report_current = Lingua::EN::Readability.new(@language_arts_current)
		@language_arts_current_sentence_count = report_current.num_sentences
		@language_arts_current_word_count = report_current.num_words
		@language_arts_current_character_count = @language_arts_current.length

		prior = Lingua::EN::Sentence.sentences(@language_arts_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@language_arts_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@language_arts_diffwords = diffwords.format_as(:html)
		@language_arts_diffsent = diffsent.format_as(:html)
		@language_arts_num_versions = @language_arts_commentos.length
	elsif @language_arts_outcome_set.commentos.length == 1
		@language_arts_commentos = @language_arts_outcome_set.commentos
		@language_arts_current = @language_arts_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@language_arts_current)
		@language_arts_current_sentence_count = report_current.num_sentences
		@language_arts_current_word_count = report_current.num_words
		@language_arts_current_character_count = @language_arts_current.length

		current = Lingua::EN::Sentence.sentences(@language_arts_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@language_arts_diffwords = diffwords.format_as(:html)
		@language_arts_num_versions = @language_arts_commentos.length
	else
		@language_arts_num_versions = "0"

	end

	math_id = Subject.find_by(:subject_id => "math").id
	@math_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => math_id)
	if  (@math_outcome_set.commentos.nil? == false) && (@math_outcome_set.commentos.length > 1)

		@math_commentos = @math_outcome_set.commentos
		@math_current = @math_commentos[-1].texto
		@math_prior = @math_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@math_prior)
		@math_prior_sentence_count = report_prior.num_sentences
		@math_prior_word_count = report_prior.num_words
		@math_prior_character_count = @math_prior.length

		report_current = Lingua::EN::Readability.new(@math_current)
		@math_current_sentence_count = report_current.num_sentences
		@math_current_word_count = report_current.num_words
		@math_current_character_count = @math_current.length

		prior = Lingua::EN::Sentence.sentences(@math_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@math_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@math_diffwords = diffwords.format_as(:html)
		@math_diffsent = diffsent.format_as(:html)
		@math_num_versions = @math_commentos.length
	elsif @math_outcome_set.commentos.length == 1
		@math_commentos = @math_outcome_set.commentos
		@math_current = @math_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@math_current)
		@math_current_sentence_count = report_current.num_sentences
		@math_current_word_count = report_current.num_words
		@math_current_character_count = @math_current.length

		current = Lingua::EN::Sentence.sentences(@math_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@math_diffwords = diffwords.format_as(:html)
		@math_num_versions = @math_commentos.length
	else
		@math_num_versions = "0"

	end

	social_studies_id = Subject.find_by(:subject_id => "social_studies").id
	@social_studies_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => social_studies_id)
	if  (@social_studies_outcome_set.commentos.nil? == false) && (@social_studies_outcome_set.commentos.length > 1)

		@social_studies_commentos = @social_studies_outcome_set.commentos
		@social_studies_current = @social_studies_commentos[-1].texto
		@social_studies_prior = @social_studies_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@social_studies_prior)
		@social_studies_prior_sentence_count = report_prior.num_sentences
		@social_studies_prior_word_count = report_prior.num_words
		@social_studies_prior_character_count = @social_studies_prior.length

		report_current = Lingua::EN::Readability.new(@social_studies_current)
		@social_studies_current_sentence_count = report_current.num_sentences
		@social_studies_current_word_count = report_current.num_words
		@social_studies_current_character_count = @social_studies_current.length

		prior = Lingua::EN::Sentence.sentences(@social_studies_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@social_studies_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@social_studies_diffwords = diffwords.format_as(:html)
		@social_studies_diffsent = diffsent.format_as(:html)
		@social_studies_num_versions = @social_studies_commentos.length
	elsif @social_studies_outcome_set.commentos.length == 1
		@social_studies_commentos = @social_studies_outcome_set.commentos
		@social_studies_current = @social_studies_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@social_studies_current)
		@social_studies_current_sentence_count = report_current.num_sentences
		@social_studies_current_word_count = report_current.num_words
		@social_studies_current_character_count = @social_studies_current.length

		current = Lingua::EN::Sentence.sentences(@social_studies_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@social_studies_diffwords = diffwords.format_as(:html)
		@social_studies_num_versions = @social_studies_commentos.length
	else
		@social_studies_num_versions = "0"

	end

	science_id = Subject.find_by(:subject_id => "science").id
	@science_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => science_id)
	if  (@science_outcome_set.commentos.nil? == false) && (@science_outcome_set.commentos.length > 1)

		@science_commentos = @science_outcome_set.commentos
		@science_current = @science_commentos[-1].texto
		@science_prior = @science_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@science_prior)
		@science_prior_sentence_count = report_prior.num_sentences
		@science_prior_word_count = report_prior.num_words
		@science_prior_character_count = @science_prior.length

		report_current = Lingua::EN::Readability.new(@science_current)
		@science_current_sentence_count = report_current.num_sentences
		@science_current_word_count = report_current.num_words
		@science_current_character_count = @science_current.length

		prior = Lingua::EN::Sentence.sentences(@science_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@science_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@science_diffwords = diffwords.format_as(:html)
		@science_diffsent = diffsent.format_as(:html)
		@science_num_versions = @science_commentos.length
	elsif @science_outcome_set.commentos.length == 1
		@science_commentos = @science_outcome_set.commentos
		@science_current = @science_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@science_current)
		@science_current_sentence_count = report_current.num_sentences
		@science_current_word_count = report_current.num_words
		@science_current_character_count = @science_current.length

		current = Lingua::EN::Sentence.sentences(@science_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@science_diffwords = diffwords.format_as(:html)
		@science_num_versions = @science_commentos.length
	else
		@science_num_versions = "0"

	end

	work_study_id = Subject.find_by(:subject_id => "work_study").id
	@work_study_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => work_study_id)
	if  (@work_study_outcome_set.commentos.nil? == false) && (@work_study_outcome_set.commentos.length > 1)

		@work_study_commentos = @work_study_outcome_set.commentos
		@work_study_current = @work_study_commentos[-1].texto
		@work_study_prior = @work_study_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@work_study_prior)
		@work_study_prior_sentence_count = report_prior.num_sentences
		@work_study_prior_word_count = report_prior.num_words
		@work_study_prior_character_count = @work_study_prior.length

		report_current = Lingua::EN::Readability.new(@work_study_current)
		@work_study_current_sentence_count = report_current.num_sentences
		@work_study_current_word_count = report_current.num_words
		@work_study_current_character_count = @work_study_current.length

		prior = Lingua::EN::Sentence.sentences(@work_study_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@work_study_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@work_study_diffwords = diffwords.format_as(:html)
		@work_study_diffsent = diffsent.format_as(:html)
		@work_study_num_versions = @work_study_commentos.length
	elsif @work_study_outcome_set.commentos.length == 1
		@work_study_commentos = @work_study_outcome_set.commentos
		@work_study_current = @work_study_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@work_study_current)
		@work_study_current_sentence_count = report_current.num_sentences
		@work_study_current_word_count = report_current.num_words
		@work_study_current_character_count = @work_study_current.length

		current = Lingua::EN::Sentence.sentences(@work_study_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@work_study_diffwords = diffwords.format_as(:html)
		@work_study_num_versions = @work_study_commentos.length
	else
		@work_study_num_versions = "0"

	end

	citizenship_id = Subject.find_by(:subject_id => "citizenship").id
	@citizenship_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => citizenship_id)
	if  (@citizenship_outcome_set.commentos.nil? == false) && (@citizenship_outcome_set.commentos.length > 1)

		@citizenship_commentos = @citizenship_outcome_set.commentos
		@citizenship_current = @citizenship_commentos[-1].texto
		@citizenship_prior = @citizenship_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@citizenship_prior)
		@citizenship_prior_sentence_count = report_prior.num_sentences
		@citizenship_prior_word_count = report_prior.num_words
		@citizenship_prior_character_count = @citizenship_prior.length

		report_current = Lingua::EN::Readability.new(@citizenship_current)
		@citizenship_current_sentence_count = report_current.num_sentences
		@citizenship_current_word_count = report_current.num_words
		@citizenship_current_character_count = @citizenship_current.length

		prior = Lingua::EN::Sentence.sentences(@citizenship_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@citizenship_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@citizenship_diffwords = diffwords.format_as(:html)
		@citizenship_diffsent = diffsent.format_as(:html)
		@citizenship_num_versions = @citizenship_commentos.length
	elsif @citizenship_outcome_set.commentos.length == 1
		@citizenship_commentos = @citizenship_outcome_set.commentos
		@citizenship_current = @citizenship_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@citizenship_current)
		@citizenship_current_sentence_count = report_current.num_sentences
		@citizenship_current_word_count = report_current.num_words
		@citizenship_current_character_count = @citizenship_current.length

		current = Lingua::EN::Sentence.sentences(@citizenship_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@citizenship_diffwords = diffwords.format_as(:html)
		@citizenship_num_versions = @citizenship_commentos.length
	else
		@citizenship_num_versions = "0"

	end

	art_id = Subject.find_by(:subject_id => "art").id
	@art_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => art_id)
	if  (@art_outcome_set.commentos.nil? == false) && (@art_outcome_set.commentos.length > 1)

		@art_commentos = @art_outcome_set.commentos
		@art_current = @art_commentos[-1].texto
		@art_prior = @art_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@art_prior)
		@art_prior_sentence_count = report_prior.num_sentences
		@art_prior_word_count = report_prior.num_words
		@art_prior_character_count = @art_prior.length

		report_current = Lingua::EN::Readability.new(@art_current)
		@art_current_sentence_count = report_current.num_sentences
		@art_current_word_count = report_current.num_words
		@art_current_character_count = @art_current.length

		prior = Lingua::EN::Sentence.sentences(@art_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@art_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@art_diffwords = diffwords.format_as(:html)
		@art_diffsent = diffsent.format_as(:html)
		@art_num_versions = @art_commentos.length
	elsif @art_outcome_set.commentos.length == 1
		@art_commentos = @art_outcome_set.commentos
		@art_current = @art_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@art_current)
		@art_current_sentence_count = report_current.num_sentences
		@art_current_word_count = report_current.num_words
		@art_current_character_count = @art_current.length

		current = Lingua::EN::Sentence.sentences(@art_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@art_diffwords = diffwords.format_as(:html)
		@art_num_versions = @art_commentos.length
	else
		@art_num_versions = "0"

	end

	ict_id = Subject.find_by(:subject_id => "ict").id
	@ict_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => ict_id)
	if  (@ict_outcome_set.commentos.nil? == false) && (@ict_outcome_set.commentos.length > 1)

		@ict_commentos = @ict_outcome_set.commentos
		@ict_current = @ict_commentos[-1].texto
		@ict_prior = @ict_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@ict_prior)
		@ict_prior_sentence_count = report_prior.num_sentences
		@ict_prior_word_count = report_prior.num_words
		@ict_prior_character_count = @ict_prior.length

		report_current = Lingua::EN::Readability.new(@ict_current)
		@ict_current_sentence_count = report_current.num_sentences
		@ict_current_word_count = report_current.num_words
		@ict_current_character_count = @ict_current.length

		prior = Lingua::EN::Sentence.sentences(@ict_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@ict_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@ict_diffwords = diffwords.format_as(:html)
		@ict_diffsent = diffsent.format_as(:html)
		@ict_num_versions = @ict_commentos.length
	elsif @ict_outcome_set.commentos.length == 1
		@ict_commentos = @ict_outcome_set.commentos
		@ict_current = @ict_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@ict_current)
		@ict_current_sentence_count = report_current.num_sentences
		@ict_current_word_count = report_current.num_words
		@ict_current_character_count = @ict_current.length

		current = Lingua::EN::Sentence.sentences(@ict_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@ict_diffwords = diffwords.format_as(:html)
		@ict_num_versions = @ict_commentos.length
	else
		@ict_num_versions = "0"

	end

	music_id = Subject.find_by(:subject_id => "music").id
	@music_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => music_id)
	if  (@music_outcome_set.commentos.nil? == false) && (@music_outcome_set.commentos.length > 1)

		@music_commentos = @music_outcome_set.commentos
		@music_current = @music_commentos[-1].texto
		@music_prior = @music_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@music_prior)
		@music_prior_sentence_count = report_prior.num_sentences
		@music_prior_word_count = report_prior.num_words
		@music_prior_character_count = @music_prior.length

		report_current = Lingua::EN::Readability.new(@music_current)
		@music_current_sentence_count = report_current.num_sentences
		@music_current_word_count = report_current.num_words
		@music_current_character_count = @music_current.length

		prior = Lingua::EN::Sentence.sentences(@music_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@music_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@music_diffwords = diffwords.format_as(:html)
		@music_diffsent = diffsent.format_as(:html)
		@music_num_versions = @music_commentos.length
	elsif @music_outcome_set.commentos.length == 1
		@music_commentos = @music_outcome_set.commentos
		@music_current = @music_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@music_current)
		@music_current_sentence_count = report_current.num_sentences
		@music_current_word_count = report_current.num_words
		@music_current_character_count = @music_current.length

		current = Lingua::EN::Sentence.sentences(@music_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@music_diffwords = diffwords.format_as(:html)
		@music_num_versions = @music_commentos.length
	else
		@music_num_versions = "0"

	end

	pe_id = Subject.find_by(:subject_id => "pe").id
	@pe_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => pe_id)
	if  (@pe_outcome_set.commentos.nil? == false) && (@pe_outcome_set.commentos.length > 1)

		@pe_commentos = @pe_outcome_set.commentos
		@pe_current = @pe_commentos[-1].texto
		@pe_prior = @pe_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@pe_prior)
		@pe_prior_sentence_count = report_prior.num_sentences
		@pe_prior_word_count = report_prior.num_words
		@pe_prior_character_count = @pe_prior.length

		report_current = Lingua::EN::Readability.new(@pe_current)
		@pe_current_sentence_count = report_current.num_sentences
		@pe_current_word_count = report_current.num_words
		@pe_current_character_count = @pe_current.length

		prior = Lingua::EN::Sentence.sentences(@pe_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@pe_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@pe_diffwords = diffwords.format_as(:html)
		@pe_diffsent = diffsent.format_as(:html)
		@pe_num_versions = @pe_commentos.length
	elsif @pe_outcome_set.commentos.length == 1
		@pe_commentos = @pe_outcome_set.commentos
		@pe_current = @pe_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@pe_current)
		@pe_current_sentence_count = report_current.num_sentences
		@pe_current_word_count = report_current.num_words
		@pe_current_character_count = @pe_current.length

		current = Lingua::EN::Sentence.sentences(@pe_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@pe_diffwords = diffwords.format_as(:html)
		@pe_num_versions = @pe_commentos.length
	else
		@pe_num_versions = "0"

	end

	thai_id = Subject.find_by(:subject_id => "thai").id
	@thai_outcome_set = @skill_track.outcome_sets.find_by(:subject_id => thai_id)
	if  (@thai_outcome_set.commentos.nil? == false) && (@thai_outcome_set.commentos.length > 1)

		@thai_commentos = @thai_outcome_set.commentos
		@thai_current = @thai_commentos[-1].texto
		@thai_prior = @thai_commentos[-2].texto

		report_prior = Lingua::EN::Readability.new(@thai_prior)
		@thai_prior_sentence_count = report_prior.num_sentences
		@thai_prior_word_count = report_prior.num_words
		@thai_prior_character_count = @thai_prior.length

		report_current = Lingua::EN::Readability.new(@thai_current)
		@thai_current_sentence_count = report_current.num_sentences
		@thai_current_word_count = report_current.num_words
		@thai_current_character_count = @thai_current.length

		prior = Lingua::EN::Sentence.sentences(@thai_prior).join("\n")
		current = Lingua::EN::Sentence.sentences(@thai_current).join("\n")

		diffsent = Differ.diff_by_line(current, prior)
		diffwords = Differ.diff_by_word(current, prior)

		@thai_diffwords = diffwords.format_as(:html)
		@thai_diffsent = diffsent.format_as(:html)
		@thai_num_versions = @thai_commentos.length
	elsif @thai_outcome_set.commentos.length == 1
		@thai_commentos = @thai_outcome_set.commentos
		@thai_current = @thai_commentos[0].texto
		

		report_current = Lingua::EN::Readability.new(@thai_current)
		@thai_current_sentence_count = report_current.num_sentences
		@thai_current_word_count = report_current.num_words
		@thai_current_character_count = @thai_current.length

		current = Lingua::EN::Sentence.sentences(@thai_current).join("\n")

		diffwords = Differ.diff_by_word(current, "")

		@thai_diffwords = diffwords.format_as(:html)
		@thai_num_versions = @thai_commentos.length
	else
		@thai_num_versions = "0"

	end
	haml :"grading/commenting", :layout => :teacher_layout
end

# grades_form[language_arts_grade_#{o.indexo}]

# unless form["language_arts_comment"].nil?
# 	language_arts_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "language_arts"))
# 	language_arts_outcome_set.commentos.create!(:texto => form["language_arts_comment"])
# 	language_arts_outcome_set.save
# end	

post "/grading/submit/:subject_id/:student_id/:skill_track_id" do
	form = params[:grades_form]

	student = Student.find_by(:id => params[:student_id])
	skill_track = student.skill_tracks.find_by(:id => params[:skill_track_id])
	
	language_arts_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "language_arts"))
	language_arts_outcome_set.outcomes.each do |outcome|
		grade = form["language_arts_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	math_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "math"))
	math_outcome_set.outcomes.each do |outcome|
		grade = form["math_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	social_studies_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "social_studies"))
	social_studies_outcome_set.outcomes.each do |outcome|
		grade = form["social_studies_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	science_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "science"))
	science_outcome_set.outcomes.each do |outcome|
		grade = form["science_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	work_study_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "work_study"))
	work_study_outcome_set.outcomes.each do |outcome|
		grade = form["work_study_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	citizenship_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "citizenship"))
	citizenship_outcome_set.outcomes.each do |outcome|
		grade = form["citizenship_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	art_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "art"))
	art_outcome_set.outcomes.each do |outcome|
		grade = form["art_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	ict_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "ict"))
	ict_outcome_set.outcomes.each do |outcome|
		grade = form["ict_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	music_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "music"))
	music_outcome_set.outcomes.each do |outcome|
		grade = form["music_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	pe_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "pe"))
	pe_outcome_set.outcomes.each do |outcome|
		grade = form["pe_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	thai_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "thai"))
	thai_outcome_set.outcomes.each do |outcome|
		grade = form["thai_grade_#{outcome.indexo}"]
		if gradesoap(grade)
			grade = gradesoap(grade)
			outcome.update_attributes!(:grade => grade)
		end
	end

	redirect to("/grading/#{params[:student_id]}\##{params[:subject_id]}")
end


post "/comment/submit/:subject_id/:student_id/:skill_track_id" do
	form = params[:comment_form]

	student = Student.find_by(:id => params[:student_id])
	skill_track = student.skill_tracks.find_by(:id => params[:skill_track_id])

unless form["language_arts_comment"].nil?
	language_arts_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "language_arts"))
	#language_arts_outcome_set.commentos.create!(:texto => form["language_arts_comment"])
	raw_comment = form["language_arts_comment"]
	processed_comment = raw_comment.paragraph_prep
	doub = doublespacer(processed_comment)
	doub.paragraph_reinsertion
	language_arts_outcome_set.commentos.create!(:texto => doub)

	language_arts_outcome_set.save
end	

unless form["math_comment"].nil?
	math_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "math"))
	math_outcome_set.commentos.create!(:texto => form["math_comment"])
	math_outcome_set.save
end	

unless form["social_studies_comment"].nil?
	social_studies_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "social_studies"))
	social_studies_outcome_set.commentos.create!(:texto => form["social_studies_comment"])
	social_studies_outcome_set.save
end	

unless form["science_comment"].nil?
	science_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "science"))
	science_outcome_set.commentos.create!(:texto => form["science_comment"])
	science_outcome_set.save
end	

unless form["work_study_comment"].nil?
	work_study_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "work_study"))
	work_study_outcome_set.commentos.create!(:texto => form["work_study_comment"])
	work_study_outcome_set.save
end	

unless form["citizenship_comment"].nil?
	citizenship_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "citizenship"))
	citizenship_outcome_set.commentos.create!(:texto => form["citizenship_comment"])
	citizenship_outcome_set.save
end	

unless form["art_comment"].nil?
	art_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "art"))
	art_outcome_set.commentos.create!(:texto => form["art_comment"])
	art_outcome_set.save
end	

unless form["ict_comment"].nil?
	ict_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "ict"))
	ict_outcome_set.commentos.create!(:texto => form["ict_comment"])
	ict_outcome_set.save
end	

unless form["music_comment"].nil?
	music_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "music"))
	music_outcome_set.commentos.create!(:texto => form["music_comment"])
	music_outcome_set.save
end	

unless form["pe_comment"].nil?
	pe_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "pe"))
	pe_outcome_set.commentos.create!(:texto => form["pe_comment"])
	pe_outcome_set.save
end	

unless form["thai_comment"].nil?
	thai_outcome_set = skill_track.outcome_sets.find_by(:subject_id => Subject.find_by(:subject_id => "thai"))
	thai_outcome_set.commentos.create!(:texto => form["thai_comment"])
	thai_outcome_set.save
end		

	redirect to("/commenting/#{params[:student_id]}\##{params[:subject_id]}")
end






























