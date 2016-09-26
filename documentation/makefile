#!/usr/bin/make -f
## makefile
## Mac Radigan

.PHONY: clean preview init all doc fig

target=./sicp

temp=.

export TEXINPUTS=/usr/share/texlive/texmf-dist/tex//
#export BIBINPUTS=./bib

GSRC = \
  graphviz/e-2-24-binary.dot \
  graphviz/e-2-24-box-and-pointer.dot
GOBJ = $(GSRC:.dot=.png)

all: init doc

doc: fig
	pdflatex --shell-escape --output-directory=$(temp) --file-line-error --interaction=nonstopmode $(target)
	bibtex $(target)
	pdflatex --shell-escape --output-directory=$(temp) --file-line-error --interaction=nonstopmode $(target)
	mv $(temp)/$(target).pdf .

fig: $(GOBJ)

%.png : %.dot
	dot -Tpng $< > $@

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
	\rm -f graphviz/*.eps
	\rm -f graphviz/*.png
	\rm -f graphviz/*.pdf

## *EOF*
