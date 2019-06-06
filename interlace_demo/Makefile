include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d


all:	interlace.dsk

interlace.dsk:	INTERLACE HELLO
	$(DOS33) -y interlace.dsk SAVE A HELLO
	$(DOS33) -y interlace.dsk BSAVE -a 0x1000 INTERLACE

####

HELLO:  hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO


####

INTERLACE:	interlace.o
	ld65 -o INTERLACE interlace.o -C ../linker_scripts/apple2_1000.inc

interlace.o:	interlace.s gr_copy.s \
	k_40_48d.inc
	ca65 -o interlace.o interlace.s -l interlace.lst

####

k_40_48d.inc:	k_40_48d.png
	$(PNG_TO_40x48D) asm k_40_48d.png k > k_40_48d.inc

###


install:	


clean:		
		rm -f *~ *.o *.lst *.inc INTERLACE HELLO
