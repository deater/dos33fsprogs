include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	chiptune_player.dsk

chiptune_player.dsk:	CHIPTUNE_PLAYER OUT.0
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1000 CHIPTUNE_PLAYER
	$(DOS33) -y chiptune_player.dsk SAVE B OUT.0
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x6000 OUT.0


CHIPTUNE_PLAYER:	chiptune_player.o
	ld65 -o CHIPTUNE_PLAYER chiptune_player.o -C ../linker_scripts/apple2_1000.inc

chiptune_player.o:	chiptune_player.s \
	../asm_routines/mockingboard.s \
	../asm_routines/dos33_routines.s \
	rasterbars.s \
	chip_title.inc zp.inc
	ca65 -o chiptune_player.o chiptune_player.s -l chiptune_player.lst

clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER

