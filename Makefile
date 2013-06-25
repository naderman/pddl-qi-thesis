pdf : images
	rubber --cache --pdf *.tex

images :
	if [ -d figures/ ]; then \
		for SVG_FILE in `find figures/ -name '*.svg'` ; \
	    do \
			TARGET=`dirname "$$SVG_FILE"`/`basename "$$SVG_FILE" ".svg"`.png ; \
			if [ ! -f "$$TARGET" ]; then \
				inkscape --export-background-opacity=0 --export-dpi=90 "--export-png=$$TARGET" "$$SVG_FILE" ; \
			elif [ `date -r $$SVG_FILE +%s` -gt `date -r $$TARGET +%s` ]; then \
				inkscape --export-background-opacity=0 --export-dpi=90 "--export-png=$$TARGET" "$$SVG_FILE" ; \
			fi; \
			\
			TARGET=`dirname "$$SVG_FILE"`/`basename "$$SVG_FILE" ".svg"`.pdf ; \
			if [ ! -f "$$TARGET" ]; then \
				inkscape "--export-pdf=$$TARGET" "$$SVG_FILE" ; \
			elif [ `date -r $$SVG_FILE +%s` -gt `date -r $$TARGET +%s` ]; then \
				inkscape "--export-pdf=$$TARGET" "$$SVG_FILE" ; \
			fi; \
		done; \
	fi

clean :
	rubber --clean *.pdf
	rm -f *.out *.nav *.snm *.bbl *.blg *.vrb
	rm -f rubber.cache

distclean : clean
	rm -f *.pdf
	if [ -d figures/ ]; then \
		rm -f figures/*.pdf ; \
		rm -f figures/*.png ; \
	fi

