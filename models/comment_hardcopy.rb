# encoding: utf-8

class CommentHardcopy
	#include Mongoid::Document
	require "haml"
	def pdf_path
		@pdf_path
	end
	def render_file(path, filename)
		contents = File.read("#{path}#{filename}")
		Haml::Engine.new(contents).render(scope = self, locals = {})
	end
	
	def initialize(data, template_path, output_path)
		base_dir = "#{Dir.home}/development/rma-reportcards/"
		@data = data
		@template_path = template_path
		comment_hardcopy = File.read("#{template_path}comment_hardcopy.haml")
		haml_engine = Haml::Engine.new(comment_hardcopy)
		output = haml_engine.render(scope = self)#, locals = {})
		html_path = "#{output_path}comment_hardcopy.html"
		File.open(html_path, 'w') { |f| f.write(output) }
		pdf_name = "comment_hardcopy_#{Time.now.stamp("2000-12-31 4:00PM")}.pdf".gsub(/\s/, '_')
		@pdf_path = "/reports/comment_hardcopies/#{pdf_name}"
		
		`#{base_dir}vendor/wkhtmltox/bin/wkhtmltopdf -s a4 -T 10 -B 10 -L 10 -R 10 #{html_path} #{output_path}#{pdf_name}`
		
	end
end