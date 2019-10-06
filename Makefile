# Custom Makefile for Compiling Research Diaries
# ----------------------------------------------
#
#  Author:   Mikhail Klassen
#  Email:    klassm@mcmaster.ca
#  Created:  21 November 2011
#  Modified: 3 January 2012
#  Modified: 6. October 2019 Stefan Hanke; minor changes. (bibersupport)

# Set the diary year you wish to compile and user info
YEAR := 2019
AUTHOR := Stefan Hanke
INSTITUTION := University of Bremen
BIBLIBRARYFILE := library.bib

# Do not edit past this line
RM := rm -rf
SHELL := /bin/bash

TEXFILE := $(YEAR)-Research-Diary.tex
LOGFILE := $(YEAR)-Research-Diary.log

BCFBIBFILE := $(YEAR)-Research-Diary.bcf

DVIFILE := $(YEAR)-Research-Diary.dvi
PSFILE := $(YEAR)-Research-Diary.ps
PDFFILE := $(YEAR)-Research-Diary.pdf

AUXFILE := $(YEAR)-Research-Diary.aux
OUTFILE := $(YEAR)-Research-Diary.out

.PHONY : clean

anthology:
	-@echo 'Creating anthology for research diary entries from the year $(YEAR)'
	-@$(SHELL) src/create_anthology.sh "$(YEAR)" "$(AUTHOR)" "$(INSTITUTION)" "$(BIBLIBRARYFILE)"
	-pdflatex -interaction=nonstopmode $(TEXFILE)
	-biber $(BCFBIBFILE)
	-pdflatex -interaction=nonstopmode $(TEXFILE)
	-pdflatex -interaction=nonstopmode $(TEXFILE)
	-open $(PDFFILE)
#	-latex -interaction=batchmode -halt-on-error $(TEXFILE)
#	-dvips -q -o "$(PSFILE)" "$(DVIFILE)" -R0
#	-ps2pdf "$(PSFILE)" "$(PDFFILE)"
#	-okular $(PDFFILE)

anthologyfast:
	-@echo 'Creating anthology for research diary entries from the year $(YEAR)'
	-@$(SHELL) src/create_anthology.sh "$(YEAR)" "$(AUTHOR)" "$(INSTITUTION)" "$(BIBLIBRARYFILE)"
	-pdflatex -interaction=nonstopmode $(TEXFILE)
#	-open $(PDFFILE)

clean:
	-$(RM) $(TEXFILE)
	-$(RM) $(LOGFILE) $(DVIFILE) $(PSFILE) $(AUXFILE) $(OUTFILE) $(BCFBIBFILE)
	-$(RM) *.tmp
	-@echo 'Done cleaning'
