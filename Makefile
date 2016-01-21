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
outputs=$(title).html $(title).pdf $(title).tex

# Styles and templates
styledir=/home/scott/Documents/Styles
textemplate=$(styledir)/pandoc/paper-mnras.tex
htmltemplate=$(styledir)/pandoc/paper.html
css=$(styledir)/css/markdown3.css
selfcontainedcss=-H $(styledir)/css/style-open.html -H $(css) -H $(styledir)/css/style-close.html

# for cleaning purposes
clutter=*.run.xml *.aux *.bcf *.fdb_latexmk *.fls *.log *.out *.bbl *.blg *Notes.bib .figsentinel

# pandoc options
commonopts=-S -s --filter=pandoc-crossref  --from=markdown+tex_math_single_backslash
texopts=$(commonopts) --template $(textemplate) --natbib --filter=pandoc-svg.py
htmlopts=$(commonopts) --template $(htmltemplate) $(selfcontainedcss) --css $(css) --filter=pandoc-citeproc --mathjax

# make all the things!
all: $(outputexts)
figfolders: $(figdir) $(autofigdir)
bibtex:
	rm -f $(bibfile)
	cp ~/Documents/PhD/Literature/bibtex/publications-waterworlds.bib library.bib

# documents

pdf: $(title).pdf
tex: $(title).tex
html: $(title).html
archive: $(title).tar.gz

%.tar.gz: %.md pdf tex figures
	tar -czf $(title).tar.gz $(title).md $(title).pdf $(title).tex library.bib autofigs/*.pdf

%.pdf: %.tex figures
	latexmk $< -pdf -e '$$pdflatex=q/xelatex %O %S/'

%.tex: %.md $(textemplate) | figures bibtex
	pandoc $< $(texopts) -o $@

%.html: %.md $(css) $(htmltemplate) | figures
	pandoc $< $(htmlopts) -o $@


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


# upload to web

rsync_upload: html pdf archive
	rsync . -rvz --include='*/' --include='figdata/*.ipynb' --include='*.pdf' --include='*.svg' --include='*.html' --include='*.tar.gz' --exclude='*' --progress --links --delete -e "ssh -p 22" swt30@muon1.ast.cam.ac.uk:/home/swt30/public_html/files/papers/waterworlds/


# cleaning

clean:
	latexmk -C -f $(title).tex
	rm -rf $(outputs) $(clutter) $(autofigdir)/*

rsync_clean:
	mkdir -p empty_local_folder
	rsync -arv --delete empty_local_folder/ swt30@muon1.ast.cam.ac.uk:/home/swt30/public_html/files/papers/waterworlds/
	rmdir empty_local_folder

.PHONY: all clean rsync_upload rsync_clean figures forcefigures
