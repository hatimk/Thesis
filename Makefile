# makefile for Mac OSX + I-installer Latex distribution
PATH+=/sw/bin:/sw/sbin:/opt/local/bin:/opt/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/teTeX/bin/i386-apple-darwin-current:/usr/X11R6/bin:/usr/local/gwTeX/bin/i386-apple-darwin-current/
DIR:=./build
#LATEX:=pdflatex -file-line-error -output-directory=${DIR} -interaction=nonstopmode
LATEX:=pdflatex -file-line-error -output-directory=${DIR}
BIBTEX:=bibtex
MAIN:=thesis
OUT:=${DIR}/${MAIN}

${OUT}.pdf:${MAIN}.tex ${OUT}.bbl ${OUT}.blg ${wildcard resources/*.pdf} headers.tex cover.tex
	ln -sf build/thesis.log thesis.log
	${LATEX} $<
	${LATEX} $<

${OUT}.bbl ${OUT}.blg: biblio.bib
	${LATEX} ${MAIN}.tex
	${LATEX} ${MAIN}.tex
	#for i in $$(grep -l bibdata build/bu*.aux);do bibtex $$i;done
	#for i in build/bu*.aux;do bibtex $$i;done
	${BIBTEX} ${OUT}
	${LATEX} ${MAIN}.tex

view: ${OUT}.pdf
	osascript reload.txt $<

final:
	${LATEX} ${MAIN}.tex
	${LATEX} ${MAIN}.tex
	${BIBTEX} ${OUT}
	${LATEX} ${MAIN}.tex
	${LATEX} ${MAIN}.tex
	${LATEX} ${MAIN}.tex

clean:
	rm -rf build/*
