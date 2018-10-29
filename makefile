# ---------------------------------------------------------
# type "make" command in Unix to create the PDF file
# ---------------------------------------------------------

# Main filename
TEX=main
MODE=handout
TARG=$(TEX)-$(MODE)
OUT=$(notdir $(shell pwd))
COMP=pdflatex
JOBNAME=$(OUT)-$(MODE)
OPTS=--file-line-error --jobname=$(JOBNAME)
ERR_FILTER='info/warning/error\|file:line:error\|errorbars'
NOW=`date +'%Y%m%d-%H%M'`
BIB=refs.bib
# ---------------------------------------------------------

.PHONY: all clean

all: $(TEX).tex $(TARG).tex notes/*.tex tikz/*.tex 
	$(COMP) $(OPTS) $(TARG)
	$(COMP) $(OPTS) $(TARG)
	@rm -f $(OUT)-*-*.pdf
	@cp $(OUT).pdf $(OUT)-$(NOW).pdf
	@cp $(OUT).pdf $(OUT)-preview.pdf
	@echo;
	@echo; echo 'WARNINGS:'; grep -i 'warning' $(JOBNAME).log | grep -v $(ERR_FILTER) || true
	@echo; echo 'ERRORS:'; grep -i 'error' $(JOBNAME).log | grep -v $(ERR_FILTER) || true
	@echo; echo 'OVER/UNDERFULL BOXES:'; grep -i 'erfull' $(JOBNAME).log || true


$(TEX).bbl: $(BIB)
	$(COMP) $(OPTS) $(TEX) --draftmode
	bibtex ${TEX}
	$(COMP) $(OPTS) $(TEX) --draftmode

error:
	@# '|| true' forces exit code '0' when no word is matched by grep (return code 1)
	@echo; echo 'WARNINGS:'; grep -i 'warning' $(TEX).log | grep -v $(ERR_FILTER) || true
	@echo; echo 'ERRORS:'; grep -i 'error' $(TEX).log | grep -v $(ERR_FILTER) || true
	@echo; echo 'OVER/UNDERFULL BOXES:'; grep -i 'erfull' $(TEX).log || true

clean:
	rm -f ./*.nav ./*.aux ./*.bbl ./*.blg ./*.glg ./*.glo ./*.gls ./*.ilg ./*.ist ./*.lof ./*.log ./*.lot ./*.nlo ./*.nls ./*.out ./*.toc ./*.dep ./*.md5 ./*.makefile ./*.figlist ./*.dpth ./*-figure*.pdf ./*.alg ./*.acr ./*.acn ./*.xml ./*.bcfi ./*.snm
