include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	mock_player.dsk

mock_player.dsk:	CHIPTUNE_PLAYER OUT.0
	$(DOS33) -y mock_player.dsk BSAVE -a 0x1000 CHIPTUNE_PLAYER
	$(DOS33) -y mock_player.dsk BSAVE -a 0x4000 OUT.0


CHIPTUNE_PLAYER:	chiptune_player.o
	ld65 -o CHIPTUNE_PLAYER chiptune_player.o -C ../linker_scripts/apple2_1000.inc

chiptune_player.o:	chiptune_player.s \
	../asm_routines/mockingboard.s \
	../asm_routines/lzss_decompress.s \
	chip_title.inc
	ca65 -o chiptune_player.o chiptune_player.s -l chiptune_player.lst

clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER

