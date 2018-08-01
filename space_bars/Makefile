include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x48D = ../gr-utils/png_to_40x48d

all:	space_bars.dsk

space_bars.dsk:	SPACE_BARS
	$(DOS33) -y space_bars.dsk BSAVE -a 0x1000 SPACE_BARS


####

SPACE_BARS:	space_bars.o
	ld65 -o SPACE_BARS space_bars.o -C ../linker_scripts/apple2_1000.inc

space_bars.o:	space_bars.s gr_copy.s \
	spacebars_title.inc
	ca65 -o space_bars.o space_bars.s -l space_bars.lst

####

spacebars_title.inc:	./images/spacebars_title_scaled.png
	$(PNG_TO_40x48D) asm ./images/spacebars_title_scaled.png spacebars_title > spacebars_title.inc

###

clean:		
		rm -f *~ *.o *.lst *.inc SPACE_BARS


