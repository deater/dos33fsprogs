include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	chiptune_player.dsk

chiptune_player.dsk:	CHIPTUNE_PLAYER ./krw/INTRO2.KRW
	cp chiptune_empty.dsk chiptune_player.dsk
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x0C00 CHIPTUNE_PLAYER
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/CAMOUFLAGE.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/CHRISTMAS.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/CRMOROS.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/DEATH2.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/DEMO4.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/HARKONEN.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/INTRO2.KRW
#	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/KORO.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/LYRA2.KRW
#	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/MMCM.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/RANDOM.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/ROBOT.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/SDEMO.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/SPUTNIK.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/TECHNO.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/UNIVERSE.KRW
	$(DOS33) -y chiptune_player.dsk SAVE B ./krw/WAVE.KRW
#	$(DOS33) -y chiptune_player.dsk SAVE B OUT.LZ4
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x6000 OUT.0


CHIPTUNE_PLAYER:	chiptune_player.o
	ld65 -o CHIPTUNE_PLAYER chiptune_player.o -C ../linker_scripts/apple2_c00.inc

chiptune_player.o:	chiptune_player.s \
	../asm_routines/mockingboard.s \
	../asm_routines/dos33_routines.s \
	../asm_routines/lz4_decode.s \
	../asm_routines/keypress_minimal.s \
	rasterbars.s volume_bars.s interrupt_handler.s \
	chip_title.inc zp.inc
	ca65 -o chiptune_player.o chiptune_player.s -l chiptune_player.lst

clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER

