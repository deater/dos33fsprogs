include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
TOKENIZE = ../asoft_basic-utils/tokenize_asoft

all:	still_alive.dsk lyrics_to_asm

still_alive.dsk:	STILL_ALIVE TITLE.BAS
	$(DOS33) -y still_alive.dsk BSAVE -a 0x0C00 STILL_ALIVE
	$(DOS33) -y still_alive.dsk SAVE A TITLE.BAS


STILL_ALIVE:	still_alive.o
	ld65 -o STILL_ALIVE still_alive.o -C ../linker_scripts/apple2_c00.inc

still_alive.o:	still_alive.s \
	../asm_routines/mockingboard.s \
	../asm_routines/lz4_decode.s \
	display_art.s display_lyrics.s \
	interrupt_handler.s \
	ascii_art.inc lyrics.inc zp.inc
	ca65 -o still_alive.o still_alive.s -l still_alive.lst

lyrics_to_asm:	lyrics_to_asm.c
	gcc -O2 -Wall -o lyrics_to_asm lyrics_to_asm.c

TITLE.BAS:	title.bas
	$(TOKENIZE) < title.bas> TITLE.BAS

clean:	
	rm -f *~ *.o *.lst STILL_ALIVE lyrics_to_asm
