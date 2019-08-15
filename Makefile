all: clean_all data doc test paper readme

%.pdf: %.Rmd 
	cd $(<D); R -e "rmarkdown::render('$(<F)', 'pdf_document')"

%.md: %.Rmd
	cd $(<D); R -e "rmarkdown::render('$(<F)', 'md_document')"

%.docx: %.Rmd
	cd $(<D); R -e "rmarkdown::render('$(<F)', 'word_document')"

%.html: %.Rmd
	cd $(<D); R -e "rmarkdown::render('$(<F)', 'html_document')"

### CLEANING
#remove any intermediate files
clean:
	rm -f README.md

clean_all: clean clean_climate clean_census clean_nass clean_noaa clean_soil

###### DATA


###### OUTPUTS
readme: README.md
	R -e "rmarkdown::render('$(<F)')"

#Generate the paper
presentation: output/presentation/presentation.html
output/pre-presentation/half-baked.html: output/presentation/presentation.Rmd
	cd $(<D); R -e "rmarkdown::render('$(<F)')"

paper: output/paper/paper.pdf
outputs/paper/paper.pdf: output/paper/paper.Rmd output/library.bib
	cd $(<D); R -e "rmarkdown::render('$(<F)', 'pdf_document')"
	cd $(<D); R -e "rmarkdown::render('$(<F)', 'word_document')"

