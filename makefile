#!/usr/bin/make -f
## makefile
## Mac Radigan

SHELL := /bin/zsh

all: run doc

run:
	./run.sh

doc: 
	$(MAKE) -C ./documentation

## *EOF*
