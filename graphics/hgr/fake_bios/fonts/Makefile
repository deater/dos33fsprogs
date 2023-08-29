PNG2FONT = ../../../../utils/hgr-utils/png2font


all:	a2_cga_thin.inc

a2_cga_thin.inc:	a2_cga_thin.png
	$(PNG2FONT) -i -o 0x13 a2_cga_thin.png  > a2_cga_thin.inc

clean:	
	rm -f *~ *.inc
