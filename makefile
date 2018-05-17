# ---------------------------------------------------------
# type "make" command in Unix to create the PDF file
# ---------------------------------------------------------

# Main filename
TEX=example
COMP=pdflatex
OPTS=--file-line-error
ERR_FILTER='info/warning/error\|file:line:error\|errorbars'

# ---------------------------------------------------------

.PHONY: all clean

all: $(TEX).aux
	$(COMP) $(OPTS) $(TEX)
	@echo; echo 'WARNINGS and ERRORS:'; grep -i 'warning\|error' $(TEX).log | grep -v $(ERR_FILTER) || true
	@echo; echo 'OVER/UNDERFULL BOXES'; grep -i 'erfull' $(TEX).log || true

$(TEX).aux: $(TEX).tex
	$(COMP) $(OPTS) $(TEX) --draftmode

error:
	@# '|| true' forces exit code '0' when no word is matched by grep (return code 1)
	@echo 'WARNINGS and ERRORS:'; grep -i 'warning\|error' $(TEX).log | grep -v $(ERR_FILTER) || true
	@echo; echo 'OVER/UNDERFULL BOXES'; grep -i 'erfull' $(TEX).log || true

clean:
	rm -f ./*.aux ./*.bbl ./*.blg ./*.glg ./*.glo ./*.gls ./*.ilg ./*.ist ./*.lof ./*.log ./*.lot ./*.nlo ./*.nls ./*.out ./*.toc ./*.dep ./*.md5 ./*.makefile ./*.figlist ./*.dpth ./*-figure*.pdf ./*.alg ./*.acr ./*.acn ./*.xml ./*.bcf
