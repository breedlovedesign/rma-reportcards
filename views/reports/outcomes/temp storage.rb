= render_file("#{@template_path}outcomes/", "social_studies_#{@student.social_studies_l}.html.haml")
= render_file("#{@template_path}outcomes/", "science_#{@student.science_l}.html.haml")
%table(border="1" cellspacing="5" cellpadding="5")
	%tr
		%td Special Subjects
		%td Comments
= render_file("#{@template_path}outcomes/", "art_#{@student.art_l}.html.haml")
= render_file("#{@template_path}outcomes/", "ict_#{@student.ict_l}.html.haml")
= render_file("#{@template_path}outcomes/", "music_#{@student.music_l}.html.haml")
= render_file("#{@template_path}outcomes/", "pe_#{@student.pe_l}.html.haml")
= render_file("#{@template_path}outcomes/", "thai_#{@student.thai_l}.html.haml")

= render_file("#{@template_path}outcomes/", "work_study_#{@student.work_study_l}.html.haml")
= render_file("#{@template_path}outcomes/", "citizenship_#{@student.citizenship_l}.html.haml")