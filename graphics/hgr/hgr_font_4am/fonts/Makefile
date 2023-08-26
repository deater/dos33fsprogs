PNG2FONT = ../../../../utils/hgr-utils/png2font


all:	a2_lowercase_font.inc a2_cga_thin.inc

a2_lowercase_font.inc:	a2_lowercase.png
	$(PNG2FONT) -i a2_lowercase.png  > a2_lowercase_font.inc

a2_cga_thin.inc:	a2_cga_thin.png
	$(PNG2FONT) -i a2_cga_thin.png  > a2_cga_thin.inc


clean:	
	rm -f *~ *.inc
