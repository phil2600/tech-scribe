%.html: %.md style.css Makefile
	pandoc -c style.css -s -f markdown -t html --standalone -o $@ $<

%.odt: %.md Makefile
	pandoc --standalone -f markdown -t odt -o $@ $<

%.pdf: %.md %.odt
	markdown2pdf -f markdown -o $@ $<

all:  
	
#doc.html doc.odt doc.pdf
