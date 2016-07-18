#!/usr/bin/make -f
## makefile
## Mac Radigan

.PHONY: clean preview init all

target=./sicp

temp=.

export TEXINPUTS=/usr/share/texlive/texmf-dist/tex//
#export BIBINPUTS=./bib

all: init
	pdflatex --shell-escape --output-directory=$(temp) --file-line-error --interaction=nonstopmode $(target)
	bibtex $(target)
	pdflatex --shell-escape --output-directory=$(temp) --file-line-error --interaction=nonstopmode $(target)
	mv $(temp)/$(target).pdf .

init:
	-mkdir -p $(temp)

preview: 
	evince $(target).pdf

clean:
	\rm -f $(temp)/*.aux
	\rm -f $(temp)/*.bbl
	\rm -f $(temp)/*.blg
	\rm -f $(temp)/*.dvi
	\rm -f $(temp)/*.lof
	\rm -f $(temp)/*.toc
	\rm -f $(temp)/*.out
	\rm -f $(temp)/*.log
	\rm -f $(temp)/*.pdf

## *EOF*
