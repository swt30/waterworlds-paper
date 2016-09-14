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
outputexts=tex tex_revision pdf pdf_revision html html_arxiv tex_archive arxiv_archive html_archive
outputs=$(title).tex $(title)-rev.tex $(title).pdf $(title)-rev.pdf $(title).html $(title)-arxiv.html $(title)-source.tar.gz $(title)-arxiv.tar.gz $(title)-html.tar.gz

# Styles and templates
styledir=~/Documents/Styles
textemplate=$(styledir)/pandoc/paper-mnras.tex
revtextemplate=$(styledir)/pandoc/paper-mnras-revisions.tex
htmltemplate=$(styledir)/pandoc/paper.html
css=$(styledir)/css/paper.css
selfcontainedcss=-H $(styledir)/css/style-open.html -H $(css) -H $(styledir)/css/style-close.html

# for cleaning purposes
clutter=*.run.xml *.aux *.bcf *.fdb_latexmk *.fls *.log *.out *.bbl *.blg *Notes.bib .figsentinel

# pandoc options
commonopts=--filter=pandoc-critic.py --filter=pandoc-fignos --filter=pandoc-eqnos --filter=pandoc-tablenos --from=markdown -s -S
basetexopts=$(commonopts) --natbib --filter=pandoc-svg.py
texopts=$(basetexopts) --template $(textemplate)
revtexopts=$(basetexopts) --template $(revtextemplate)
htmlopts=$(commonopts) --template $(htmltemplate) $(selfcontainedcss) --css $(css) --filter=pandoc-citeproc --mathjax

# make all the things!
all: $(outputexts)

# documents
tex: $(title).tex
$(title).tex: $(title).md $(textemplate) | figures bibtex
	pandoc $(title).md $(texopts) -o $(title).tex

tex_revision: $(title)-rev.tex
$(title)-rev.tex: $(title).md $(revtextemplate) | figures bibtex
	pandoc $(title).md $(revtexopts) -o $(title)-rev.tex

pdf: $(title).pdf
$(title).pdf: $(title).tex figures
	latexmk $(title).tex -pdf

pdf_revision: $(title)-rev.pdf
$(title)-rev.pdf: $(title)-rev.tex figures
	latexmk $(title)-rev.tex -pdf

html: $(title).html
$(title).html: $(title).md $(css) $(htmltemplate) | figures
	pandoc $(title).md $(htmlopts) -o $(title).html

html_arxiv: $(title)-arxiv.html
$(title)-arxiv.html: $(title).md $(css) $(htmltemplate) | figures
	pandoc $(title).md --filter=pandoc-svg.py $(htmlopts) -o $(title)-arxiv.html

tex_archive: $(title)-source.tar.gz
$(title)-source.tar.gz: $(title).md pdf pdf_revision tex figures
	tar -czf $(title)-source.tar.gz $(title).md $(title).pdf $(title)-rev.pdf $(title).tex library.bib $(title).bbl README.md autofigs/*.pdf

arxiv_archive: $(title)-arxiv.tar.gz
$(title)-arxiv.tar.gz: $(title).md tex figures
	tar -czhf $(title)-arxiv.tar.gz $(title).md $(title).tex mnras.cls README-arXiv.md $(title).bbl autofigs/*.pdf

html_archive: $(title)-html.tar.gz
$(title)-html.tar.gz: html_arxiv figures
	tar -czf $(title)-html.tar.gz $(title)-arxiv.html autofigs/*.png

# figures
figures: .figsentinel | $(figdir) $(autofigdir)
figfolders: $(figdir) $(autofigdir)
forcefigures: | figures
	julia $(plotrunner)

.figsentinel: $(plots)
	touch .figsentinel
	julia $(plotrunner)

$(figdir):
	mkdir -p $(figdir)

$(autofigdir):
	mkdir -p $(autofigdir)

# auxiliary
bibtex:
	rm -f $(bibfile)
	cp ~/Documents/PhD/Literature/bibtex/publications-waterworlds.bib library.bib

# cleaning
clean:
	latexmk -C -f $(title).tex
	rm -rf $(outputs) $(clutter) $(autofigdir)/*

.PHONY: all clean rsync_upload rsync_clean figures forcefigures
