include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	chiptune_player.dsk chiptune_unrolled.dsk

$(DOS33):
	cd ../../utils/dos33fs-utils && make

chiptune_player.dsk:	CHIPTUNE_PLAYER ./krw/INTRO2.KRW HELLO
	cp chiptune_empty.dsk chiptune_player.dsk
	$(DOS33) -y chiptune_player.dsk SAVE A HELLO
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x0800 CHIPTUNE_PLAYER
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/CAMOUFLAGE.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/CHRISTMAS.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/CRMOROS.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/DEATH2.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/DEMO4.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/HARKONEN.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/INTRO2.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/KORO.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/LYRA2.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/MMCM.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/RANDOM.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/ROBOT.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/SDEMO.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/SPUTNIK.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/TECHNO.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/UNIVERSE.KRW
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/WAVE.KRW
#	$(DOS33) -y chiptune_player.dsk SAVE B OUT.LZ4
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x6000 OUT.0


chiptune_unrolled.dsk:	CHIPTUNE_UNROLLED ./krw/INTRO2.KRW
	cp chiptune_empty.dsk chiptune_unrolled.dsk
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x0800 CHIPTUNE_UNROLLED
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/CAMOUFLAGE.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/CHRISTMAS.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/CRMOROS.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/DEATH2.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/DEMO4.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/HARKONEN.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/INTRO2.KRW
#	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/KORO.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/LYRA2.KRW
#	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/MMCM.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/RANDOM.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/ROBOT.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/SDEMO.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/SPUTNIK.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/TECHNO.KRW
	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/UNIVERSE.KRW
#	$(DOS33) -y chiptune_unrolled.dsk BSAVE -a 0x1c00 ./krw/WAVE.KRW

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

CHIPTUNE_PLAYER:	chiptune_player.o
	ld65 -o CHIPTUNE_PLAYER chiptune_player.o -C ../../linker_scripts/apple2_800.inc

chiptune_player.o:	chiptune_player.s \
	../../asm_routines/mockingboard.s \
	../../asm_routines/dos33_routines.s \
	../../asm_routines/lz4_decode.s \
	../../asm_routines/keypress_minimal.s \
	qkumba_rts.s \
	rasterbars.s volume_bars.s interrupt_handler.s \
	song_list.inc chip_title.inc zp.inc chip_title_uncompressed.inc
	ca65 -o chiptune_player.o chiptune_player.s -l chiptune_player.lst

CHIPTUNE_UNROLLED:	chiptune_unrolled.o
	ld65 -o CHIPTUNE_UNROLLED chiptune_unrolled.o -C ../../linker_scripts/apple2_800.inc

chiptune_unrolled.o:	chiptune_player.s \
	../../asm_routines/mockingboard.s \
	../../asm_routines/dos33_routines.s \
	../../asm_routines/lz4_decode.s \
	../../asm_routines/keypress_minimal.s \
	rasterbars.s volume_bars.s interrupt_handler_unrolled.s \
	chip_title.inc zp.inc
	ca65 -D UNROLLED=1 -o chiptune_unrolled.o chiptune_player.s -l chiptune_unrolled.lst


clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER CHIPTUNE_UNROLLED

