include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG_TO_40x96 = ../gr-utils/png_to_40x96
PNG_TO_40x48D = ../gr-utils/png_to_40x48d


all:	fancy_lores_viewer.dsk

fancy_lores_viewer.dsk:	DISP4096 DISP4048D
	$(DOS33) -y fancy_lores_viewer.dsk BSAVE -a 0x1000 DISP4096
	$(DOS33) -y fancy_lores_viewer.dsk BSAVE -a 0x1000 DISP4048D
#	$(DOS33) -y fancy_lores_viewer.dsk BSAVE -a 0x2000 APPLE_ORIG.BIN
#	$(DOS33) -y fancy_lores_viewer.dsk BSAVE -a 0x2000 KATAHDIN_ORIG.BIN
#	$(DOS33) -y fancy_lores_viewer.dsk BSAVE -a 0x2000 APPLE_HGR.BIN

####

DISP4096:	disp4096.o
	ld65 -o DISP4096 disp4096.o -C ../linker_scripts/apple2_1000.inc

disp4096.o:	disp4096.s gr_copy.s \
	apple_40_96.inc katahdin_40_96.inc df_girl_40_96.inc df_girl2_40_96.inc
	ca65 -o disp4096.o disp4096.s -l disp4096.lst

####

DISP4048D:	disp4048d.o
	ld65 -o DISP4048D disp4048d.o -C ../linker_scripts/apple2_1000.inc

disp4048d.o:	disp4048d.s gr_copy.s \
	apple_40_48d.inc katahdin_40_48d.inc spacebars_40_48d.inc df_girl_40_48d.inc
	ca65 -o disp4048d.o disp4048d.s -l disp4048d.lst


###

katahdin_40_96.inc:	katahdin_40_96.png
	$(PNG_TO_40x96) asm katahdin_40_96.png katahdin > katahdin_40_96.inc

apple_40_96.inc:	apple_40_96.png
	$(PNG_TO_40x96) asm apple_40_96.png apple > apple_40_96.inc

df_girl_40_96.inc:	df_girl_40_96.png
	$(PNG_TO_40x96) asm df_girl_40_96.png df_girl > df_girl_40_96.inc

df_girl2_40_96.inc:	df_girl2_40_96.png
	$(PNG_TO_40x96) asm df_girl2_40_96.png df_girl2 > df_girl2_40_96.inc

###

spacebars_40_48d.inc:	spacebars_40_48d.png
	$(PNG_TO_40x48D) asm spacebars_40_48d.png spacebars > spacebars_40_48d.inc

katahdin_40_48d.inc:	katahdin_40_48d.png
	$(PNG_TO_40x48D) asm katahdin_40_48d.png katahdin > katahdin_40_48d.inc

apple_40_48d.inc:	apple_40_48d.png
	$(PNG_TO_40x48D) asm apple_40_48d.png apple > apple_40_48d.inc

df_girl_40_48d.inc:	df_girl_40_48d.png
	$(PNG_TO_40x48D) asm df_girl_40_48d.png df_girl > df_girl_40_48d.inc



###


install:	
		cp png_to_40x96 $(INSTALL_LOC)

clean:		
		rm -f *~ *.o *.lst *.inc png_to_40x96 png_to_40x48d DISP4096 DISP4048D


