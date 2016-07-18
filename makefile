#!/usr/bin/make -f
## makefile
## Mac Radigan

SHELL := /bin/zsh

all: run doc

run:
	./run.sh

prerequisites:
	-mkdir -p ./figures
	(cd ./figures; wget http://www.ee.cityu.edu.hk/~lmpo/lenna/len_std.jpg -o lena.jpg)

doc: 
	$(MAKE) -C ./documentation

## *EOF*
