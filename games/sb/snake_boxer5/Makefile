include ../../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
EMPTY_DISK = ../../../empty_disk/empty.dsk
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	snake_boxer5.dsk

####

snake_boxer5.dsk:	HELLO SNAKE_BOXER5
	cp $(EMPTY_DISK) snake_boxer5.dsk
	$(DOS33) -y snake_boxer5.dsk SAVE A HELLO
	$(DOS33) -y snake_boxer5.dsk BSAVE -a 0x6000 SNAKE_BOXER5

###

SNAKE_BOXER5:	snake_boxer5.o
	ld65 -o SNAKE_BOXER5 snake_boxer5.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

snake_boxer5.o:	snake_boxer5.s ../zx02_optim.s \
		../zp.inc ../hardware.inc\
		graphics/videlectrix.gr.zx02 \
		graphics/gameplay.gr.zx02
	ca65 -o snake_boxer5.o snake_boxer5.s -l snake_boxer5.lst

graphics/videlectrix.gr.zx02:	
	cd graphics && make


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o HELLO SNAKE_BOXER5

