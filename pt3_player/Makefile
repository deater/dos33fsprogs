include ../Makefile.inc

DOS33 = ../dos33fs-utils/dos33
PNG2GR = ../gr-utils/png2gr

all:	pt3_player.dsk pt3_debug.dsk

$(DOS33):
	cd ../dos33fs-utils && make

pt3_player.dsk:	PT3_PLAYER HELLO
	cp empty.dsk pt3_player.dsk
	$(DOS33) -y pt3_player.dsk SAVE A HELLO
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x1000 PT3_PLAYER
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/SR.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/EA.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/VC.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/OS.PT3
#	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/BA.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/CR.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/DF.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/F4.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/FC.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/HI.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/I2.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/IT.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/MB.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/RI.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/SD.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/FR.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/CH.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/BH.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/ND.PT3
	$(DOS33) -y pt3_player.dsk BSAVE -a 0x4000 ./music/OO.PT3


pt3_debug.dsk:	PT3_DUMPER PT3_TIMER PT3_TABLE_TEST HELLO_DEBUG DUMP
	cp empty.dsk pt3_debug.dsk
	$(DOS33) -y pt3_debug.dsk SAVE A HELLO_DEBUG HELLO
	$(DOS33) -y pt3_debug.dsk SAVE A DUMP
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x1000 PT3_DUMPER
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x1000 PT3_PLAYER
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x1000 PT3_TIMER
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x1000 PT3_TABLE_TEST
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/SR.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/EA.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/VC.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/OS.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/CR.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/DF.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/F4.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/FC.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/HI.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/I2.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/IT.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/MB.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/RI.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/SD.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/FR.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/CH.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/BH.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/ND.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/OO.PT3
	$(DOS33) -y pt3_debug.dsk BSAVE -a 0x4000 ./music/DY.PT3

HELLO:	hello.bas
	../asoft_basic-utils/tokenize_asoft < hello.bas > HELLO

HELLO_DEBUG:	hello_debug.bas
	../asoft_basic-utils/tokenize_asoft < hello_debug.bas > HELLO_DEBUG

DUMP:	dump.bas
	../asoft_basic-utils/tokenize_asoft < dump.bas > DUMP

#

PT3_PLAYER:	pt3_player.o
	ld65 -o PT3_PLAYER pt3_player.o -C ../linker_scripts/apple2_1000.inc

pt3_player.o:	pt3_player.s \
	gr_fast_clear.s random16.s fire.s \
	gr_putsprite.s put_letters.s zp.inc \
	pt3_lib_init.s pt3_lib_core.s interrupt_handler.s
	ca65 -o pt3_player.o pt3_player.s -l pt3_player.lst

#

PT3_TIMER:	pt3_timer.o
	ld65 -o PT3_TIMER pt3_timer.o -C ../linker_scripts/apple2_1000.inc

pt3_timer.o:	pt3_timer.s \
	gr_fast_clear.s zp.inc \
	pt3_lib_init.s pt3_lib_core.s
	ca65 -o pt3_timer.o pt3_timer.s -l pt3_timer.lst

#

PT3_DUMPER:	pt3_dumper.o
	ld65 -o PT3_DUMPER pt3_dumper.o -C ../linker_scripts/apple2_1000.inc

pt3_dumper.o:	pt3_dumper.s \
	gr_fast_clear.s zp.inc \
	pt3_lib_init.s pt3_lib_core.s
	ca65 -o pt3_dumper.o pt3_dumper.s -l pt3_dumper.lst

#

PT3_TABLE_TEST:	pt3_table_test.o
	ld65 -o PT3_TABLE_TEST pt3_table_test.o -C ../linker_scripts/apple2_1000.inc

pt3_table_test.o:	pt3_table_test.s \
	gr_fast_clear.s pt3_lib_core.s pt3_lib_init.s zp.inc
	ca65 -o pt3_table_test.o pt3_table_test.s -l pt3_table_test.lst

#

clean:	
	rm -f *~ TITLE.GR *.o *.lst \
		PT3_PLAYER PT3_TIMER PT3_DUMPER PT3_TABLE_TEST

