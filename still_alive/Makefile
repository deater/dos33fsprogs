include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	still_alive.dsk

still_alive.dsk:	STILL_ALIVE TITLE.BAS ENDING
	$(DOS33) -y still_alive.dsk BSAVE -a 0x0C00 STILL_ALIVE
	$(DOS33) -y still_alive.dsk BSAVE -a 0x1C00 ENDING
	$(DOS33) -y still_alive.dsk SAVE A TITLE.BAS
#	$(DOS33) -y still_alive.dsk SAVE B GLADOS.HGR

STILL_ALIVE:	still_alive.o
	ld65 -o STILL_ALIVE still_alive.o -C ../linker_scripts/apple2_c00.inc

still_alive.o:	still_alive.s \
	../asm_routines/mockingboard.s \
	../asm_routines/lz4_decode.s \
	display_art.s display_lyrics.s \
	sa_ed.s duet.s SA.ED \
	sa_mb.s ascii_art.inc \
	interrupt_handler.s \
	ascii_art.inc ascii_art_lz4.inc lyrics.inc zp.inc
	ca65 -o still_alive.o still_alive.s -l still_alive.lst

ENDING:	ending.o
	ld65 -o ENDING ending.o -C ../linker_scripts/apple2_1c00.inc

ending.o:	ending.s \
	GLADOS.HGR
	ca65 -o ending.o ending.s -l ending.lst

TITLE.BAS:	title.bas
	$(TOKENIZE) < title.bas> TITLE.BAS

clean:	
	rm -f *~ *.o *.lst STILL_ALIVE SA_ED ENDING
