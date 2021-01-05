include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	still_alive.dsk

still_alive.dsk:	SA_COMPRESSED STILL_ALIVE TITLE.BAS ENDING
	$(DOS33) -y still_alive.dsk BSAVE -a 0x5900 SA_COMPRESSED
	$(DOS33) -y still_alive.dsk BSAVE -a 0x0800 STILL_ALIVE
	$(DOS33) -y still_alive.dsk BSAVE -a 0x1800 ENDING
	$(DOS33) -y still_alive.dsk SAVE A TITLE.BAS
#	$(DOS33) -y still_alive.dsk SAVE B GLADOS.HGR

SA_COMPRESSED:	sa_compressed.o
	ld65 -o SA_COMPRESSED sa_compressed.o -C ../../linker_scripts/apple2_5900.inc

sa_compressed.o:	sa_compressed.s \
	STILL_ALIVE.lz4 ENDING.lz4 SA.ED.lz4 SA.KR4.lz4
	ca65 -o sa_compressed.o sa_compressed.s -l sa_compressed.lst

SA.ED.lz4:	SA.ED
	lz4 -f -16 SA.ED
	truncate --size=-8 SA.ED.lz4

SA.KR4.lz4:	SA.KR4
	lz4 -f -16 SA.KR4
	truncate --size=-8 SA.KR4.lz4

STILL_ALIVE.lz4:	STILL_ALIVE
	lz4 -f -16 STILL_ALIVE
	truncate --size=-8 STILL_ALIVE.lz4

ENDING.lz4:	ENDING
	lz4 -f -16 ENDING
	truncate --size=-8 ENDING.lz4


STILL_ALIVE:	still_alive.o
	ld65 -o STILL_ALIVE still_alive.o -C ../../linker_scripts/apple2_800.inc

still_alive.o:	still_alive.s \
	mockingboard_a.s lz4_decode.s \
	display_art.s display_lyrics.s \
	sa_ed.s duet.s \
	sa_mb.s ascii_art.inc \
	interrupt_handler.s \
	ascii_art.inc ascii_art_lz4.inc lyrics.inc zp.inc
	ca65 -o still_alive.o still_alive.s -l still_alive.lst


ENDING:	ending.o
	ld65 -o ENDING ending.o -C ../../linker_scripts/apple2_1800.inc

ending.o:	ending.s \
	GLADOS.HGR
	ca65 -o ending.o ending.s -l ending.lst

TITLE.BAS:	title.bas
	$(TOKENIZE) < title.bas> TITLE.BAS

clean:	
	rm -f *~ *.o *.lz4 *.lst STILL_ALIVE SA_ED ENDING SA_COMPRESSED
	cd art && make clean
