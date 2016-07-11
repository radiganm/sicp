#!/usr/bin/make -f
## makefile
## Mac Radigan

target=./sicp

export TEXINPUTS=/usr/share/texlive/texmf-dist/tex//
#export BIBINPUTS=./bib

all:
	pdflatex --shell-escape --output-directory=. --file-line-error --interaction=nonstopmode $(target)
	bibtex $(target)
	pdflatex --shell-escape --output-directory=. --file-line-error --interaction=nonstopmode $(target)

preview: 
	evince $(target).pdf

clean:
	\rm -f ./*.aux
	\rm -f ./*.bbl
	\rm -f ./*.blg
	\rm -f ./*.dvi
	\rm -f ./*.lof
	\rm -f ./*.toc
	\rm -f ./*.out
	\rm -f ./*.log
	\rm -f ./*.pdf

## *EOF*
