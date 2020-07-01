all:
	Rscript -e 'rmarkdown::render("index.Rmd", "slidy_presentation", output_file = "index.html")' && \
	Rscript -e 'rmarkdown::render("index.Rmd", "html_document", output_file = "print-version.html")' &
