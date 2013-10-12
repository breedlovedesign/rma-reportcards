= render_file("#{@template_path}outcomes/", "social_studies_#{@student_var.social_studies_l}.html.haml")
= render_file("#{@template_path}outcomes/", "science_#{@student_var.science_l}.html.haml")
%table(border="1" cellspacing="5" cellpadding="5")
	%tr
		%td Special Subjects
		%td Comments
= render_file("#{@template_path}outcomes/", "art_#{@student_var.art_l}.html.haml")
= render_file("#{@template_path}outcomes/", "ict_#{@student_var.ict_l}.html.haml")
= render_file("#{@template_path}outcomes/", "music_#{@student_var.music_l}.html.haml")
= render_file("#{@template_path}outcomes/", "pe_#{@student_var.pe_l}.html.haml")
= render_file("#{@template_path}outcomes/", "thai_#{@student_var.thai_l}.html.haml")

= render_file("#{@template_path}outcomes/", "work_study_#{@student_var.work_study_l}.html.haml")
= render_file("#{@template_path}outcomes/", "citizenship_#{@student_var.citizenship_l}.html.haml")