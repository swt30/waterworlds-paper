# Inputs
title=waterworlds
filename=$(title).md
plots=plots.ipynb
inputs=$(filename) $(plots)
bibfile=library.bib

# Figures
figdir=figs/
autofigdir=autofigs/
plotrunner=makeplots.jl

# Outputs
outputexts=html tex pdf
outputs=$(title).html $(title).pdf $(title).tex $(title)-rev.tex $(title)-rev.pdf

# Styles and templates
styledir=/home/scott/Documents/Styles
textemplate=$(styledir)/pandoc/paper-mnras.tex
revtextemplate=$(styledir)/pandoc/paper-mnras-revisions.tex
htmltemplate=$(styledir)/pandoc/paper.html
css=$(styledir)/css/markdown3.css
selfcontainedcss=-H $(styledir)/css/style-open.html -H $(css) -H $(styledir)/css/style-close.html

# for cleaning purposes
clutter=*.run.xml *.aux *.bcf *.fdb_latexmk *.fls *.log *.out *.bbl *.blg *Notes.bib .figsentinel

# pandoc options
commonopts=--filter=pandoc-fignos --filter=pandoc-eqnos --filter=pandoc-tablenos --from=markdown -s -S
basetexopts=$(commonopts) --natbib --filter=pandoc-svg.py
texopts=$(basetexopts) --template $(textemplate)
revtexopts=$(basetexopts) --template $(revtextemplate)
htmlopts=$(commonopts) --template $(htmltemplate) $(selfcontainedcss) --css $(css) --filter=pandoc-citeproc --mathjax

# make all the things!
all: $(outputexts)
figfolders: $(figdir) $(autofigdir)
bibtex:
	rm -f $(bibfile)
	cp ~/Documents/PhD/Literature/bibtex/publications-waterworlds.bib library.bib

# documents

pdf: $(title).pdf
revision_pdf: $(title)-rev.pdf
tex: $(title).tex
revision_tex: $(title)-rev.tex
html: $(title).html
archive: $(title).tar.gz

$(title).tar.gz: $(title).md pdf revision_pdf tex figures
	tar -czf $(title).tar.gz $(title).md $(title).pdf $(title)-rev.pdf $(title).tex library.bib $(title).bbl README.md autofigs/*.pdf

$(title).pdf: $(title).tex figures
	latexmk $(title).tex -pdf -e '$$pdflatex=q/xelatex %O %S/'

$(title)-rev.pdf: $(title)-rev.tex figures
	latexmk $(title)-rev.tex -pdf -e '$$pdflatex=q/xelatex %O %S/'

$(title)-rev.tex: $(title).md $(revtextemplate) | figures bibtex
	pandoc $(title).md $(revtexopts) -o $(title)-rev.tex

$(title).tex: $(title).md $(textemplate) | figures bibtex
	pandoc $(title).md $(texopts) -o $(title).tex

$(title).html: $(title).md $(css) $(htmltemplate) | figures
	pandoc $(title).md $(htmlopts) -o $(title).html


# figures

figures: .figsentinel | $(figdir) $(autofigdir)

forcefigures: | figures
	julia $(plotrunner)

.figsentinel: $(plots)
	touch .figsentinel
	julia $(plotrunner)

$(figdir):
	mkdir -p $(figdir)

$(autofigdir):
	mkdir -p $(autofigdir)


# cleaning

clean:
	latexmk -C -f $(title).tex
	rm -rf $(outputs) $(clutter) $(autofigdir)/*

.PHONY: all clean rsync_upload rsync_clean figures forcefigures
