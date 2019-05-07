include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	pt3_player.dsk

$(DOS33):
	cd ../dos33fs-utils && make

pt3_player.dsk:	PT3_PLAYER HELLO
	cp empty.dsk pt3_player.dsk
	$(DOS33) -y chiptune_player.dsk SAVE A HELLO
	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x0800 PT3_PLAYER
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/CAMOUFLAGE.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/CHRISTMAS.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/CRMOROS.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/DEATH2.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/DEMO4.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/HARKONEN.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/INTRO2.KRW
##	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/KORO.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/LYRA2.KRW
##	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/MMCM.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/RANDOM.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/ROBOT.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/SDEMO.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/SPUTNIK.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/TECHNO.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/UNIVERSE.KRW
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x1c00 ./krw/WAVE.KRW
#	$(DOS33) -y chiptune_player.dsk SAVE B OUT.LZ4
#	$(DOS33) -y chiptune_player.dsk BSAVE -a 0x6000 OUT.0

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

PT3_PLAYER:	pt3_player.o
	ld65 -o PT3_PLAYER pt3_player.o -C ../linker_scripts/apple2_800.inc

pt3_player.o:	pt3_player.s
#	mockingboard.s \
#	keypress_minimal.s \
#	qkumba_rts.s \
#	rasterbars.s volume_bars.s interrupt_handler.s \
#	song_list.inc chip_title.inc zp.inc chip_title_uncompressed.inc
	ca65 -o pt3_player.o pt3_player.s -l pt3_player.lst

clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		PT3_PLAYER

