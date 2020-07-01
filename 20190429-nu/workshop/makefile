all:
	Rscript -e 'rmarkdown::render("index.Rmd", "all")'
	/usr/bin/pandoc +RTS -K512m -RTS index.md --to html4 --from gfm-ascii_identifiers --output index.html --standalone --self-contained --highlight-style pygments --template /usr/local/lib/R/site-library/rmarkdown/rmarkdown/templates/github_document/resources/preview.html --variable 'github-markdown-css:/usr/local/lib/R/site-library/rmarkdown/rmarkdown/templates/github_document/resources/github.css' --email-obfuscation none --metadata pagetitle=Workshop
