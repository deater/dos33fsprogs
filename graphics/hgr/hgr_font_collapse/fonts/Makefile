PNG2FONT = ../../../../utils/hgr-utils/png2font


all:	a2_lowercase_font.inc

a2_lowercase_font.inc:	a2_lowercase.png
	$(PNG2FONT) -i -o 0x19 a2_lowercase.png  > a2_lowercase_font.inc

clean:	
	rm -f *~ *.inc
