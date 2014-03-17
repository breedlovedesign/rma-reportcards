# encoding: utf-8

class ReportCard
	#include Mongoid::Document
	require "haml"
	attr_reader :name_of_file
	def render_file(path, filename)
		contents = File.read("#{path}#{filename}")
		Haml::Engine.new(contents).render(scope = self, locals = {})
	end
	
	def initialize(student_var, template_path, output_path)
		@student_var = student_var
		@template_path = template_path
		report_card = File.read("#{template_path}report_card.haml")
		haml_engine = Haml::Engine.new(report_card)
		output = haml_engine.render(scope = self)
		@name_of_file = "REPORT_CARD_" + (Student.find(@student_var.id).name).gsub(/\s/,'_')
		File.open("#{output_path}#{@name_of_file}.html", 'w') { |f| f.write(output) }
		#puts output
	end
end