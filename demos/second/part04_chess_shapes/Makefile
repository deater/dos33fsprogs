include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts/


all:	CHESS

####

CHESS:	chess.o
	ld65 -o CHESS chess.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

chess.o:	chess.s \
	../zx02_optim.s \
	../hgr_copy_fast.s \
	interference.s \
	circles.s \
	falling_bars.s \
	sierzoom.s \
	hgr_partial.s \
	../irq_wait.s \
	../zp.inc ../hardware.inc ../qload.inc \
	graphics/chess_object2.hgr.zx02 \
	graphics/object.inc
	ca65 -o chess.o chess.s -l chess.lst

###

graphics/chess_object2.hgr.zx02:	
	cd graphics && make

###


clean:
	rm -f *~ *.o *.lst CHESS
	cd graphics && make clean
