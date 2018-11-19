include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	chiptune_dya.dsk

$(DOS33):
	cd ../dos33fs-utils && make

chiptune_dya.dsk:	CHIPTUNE_PLAYER HELLO
	cp chiptune_empty.dsk chiptune_dya.dsk
	$(DOS33) -y chiptune_dya.dsk SAVE A HELLO
	$(DOS33) -y chiptune_dya.dsk BSAVE -a 0x0C00 CHIPTUNE_PLAYER
	$(DOS33) -y chiptune_dya.dsk SAVE B DOTD1.KRW
	$(DOS33) -y chiptune_dya.dsk SAVE B DOTD2.KRW

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

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

CHIPTUNE_UNROLLED:	chiptune_unrolled.o
	ld65 -o CHIPTUNE_UNROLLED chiptune_unrolled.o -C ../linker_scripts/apple2_c00.inc

chiptune_unrolled.o:	chiptune_player.s \
	../asm_routines/mockingboard.s \
	../asm_routines/dos33_routines.s \
	../asm_routines/lz4_decode.s \
	../asm_routines/keypress_minimal.s \
	rasterbars.s volume_bars.s interrupt_handler_unrolled.s \
	chip_title.inc zp.inc
	ca65 -D UNROLLED=1 -o chiptune_unrolled.o chiptune_player.s -l chiptune_unrolled.lst


clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		CHIPTUNE_PLAYER HELLO

