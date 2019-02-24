include ../../../Makefile.inc

PNG2RLE = ../../../gr-utils/png2rle


all:	intro_tunnel1.inc intro_tunnel2.inc intro_gone.inc

#####

intro_tunnel1.inc:	$(PNG2RLE) \
	intro_tunnel1.png
	$(PNG2RLE) asm intro_tunnel1.png tunnel1_rle > intro_tunnel1.inc

#####

intro_tunnel2.inc:	$(PNG2RLE) \
	intro_tunnel2.png
	$(PNG2RLE) asm intro_tunnel2.png tunnel2_rle > intro_tunnel2.inc

#####

intro_gone.inc:	$(PNG2RLE) \
	intro_gone.png
	$(PNG2RLE) asm intro_gone.png gone_rle > intro_gone.inc


#####

clean:		
		rm -f *~ *.inc

