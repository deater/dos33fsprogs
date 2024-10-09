include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	SAVE_DATA

###

SAVE_DATA:	save_data.o
	ld65 -o SAVE_DATA save_data.o -C $(LINKER_SCRIPTS)/apple2_bc00.inc

save_data.o:	save_data.s ../zp.inc	# fixme, should be all of them listed
	ca65 -o save_data.o save_data.s -l save_data.lst

###

distclean:
	make clean
###

clean:	
	rm -f *~ *.o *.lst save_data SAVE_DATA
