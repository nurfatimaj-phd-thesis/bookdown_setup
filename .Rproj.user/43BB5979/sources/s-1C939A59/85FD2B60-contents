output_path = text/output/

pdf:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")'
	rm -f *.log *.mtc* *.maf *.aux *.bcf *.lof *.lot *.out *.toc *.bib *.run.xml text/front-and-back-matter/abbreviations.aux
	Rscript -e 'browseURL(paste(getwd(), list.files("$(output_path)", pattern = "*.pdf", full.names = TRUE)[[1]], sep = "/"))'

gitbook:
	Rscript -e 'bookdown::render_book("$(input_file)", output_format = "bookdown::gitbook")'
	Rscript -e 'browseURL(list.files("$(output_path)", pattern = "*.html", full.names = TRUE))'

word:
	Rscript -e 'bookdown::render_book("$(input_file)", output_format = "bookdown::word_document2")'
	Rscript -e 'browseURL(list.files("$(output_path)", pattern = "*.docx", full.names = TRUE))'

clean:
	rm -f *.log *.mtc* *.maf *.aux *.bbl *.blg *.xml

clean-knits:
	rm -f *.docx *.html *.pdf *.log *.maf *.mtc* *.tex *.toc *.out *.lof *.lot *.bcf *.aux
	rm -R *_files
	rm -R *_cache
