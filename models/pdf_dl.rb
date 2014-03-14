# encoding: utf-8

class PdfDl

	def initialize(html_dir, system = :mac)
		`html2pdf --papersize=a4  #{html_dir}*html` 
		`rm #{html_dir}*html`
		#timestamp = Time.now.stamp()
		`pdfjam  --a3paper --nup 2x1 --landscape  #{html_dir}*pdf 4,1,2,3 --outfile #{html_dir}output.pdf`
	end
end