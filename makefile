#!/usr/bin/make -f
## makefile
## Mac Radigan

SHELL := /bin/bash

all: run doc

run:
	-mkdir -p ./output
	./run.sh

prerequisites:
	-mkdir -p ./figures
	(cd ./figures; wget -o lena.jpg http://www.ee.cityu.edu.hk/~lmpo/lenna/len_std.jpg)

doc: 
	$(MAKE) -C ./documentation

## *EOF*
