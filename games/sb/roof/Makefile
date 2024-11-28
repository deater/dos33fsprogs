include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
LINKER_SCRIPTS = ../../../linker_scripts

all:	ROOF

####

ROOF:	roof.o
	ld65 -o ROOF roof.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

roof.o:	roof.s ../zx02_optim.s \
		graphics/strongbad_sample.hgr.zx02 \
		../zp.inc ../hardware.inc
	ca65 -o roof.o roof.s -l roof.lst

graphics/strongbad_sample.hgr.zx02:	
	cd graphics && make

####

clean:	
	rm -f *.lst *.o *~ ROOF

distclean:
	rm -f *.lst *.o *~ ROOF
	cd graphics && make clean
