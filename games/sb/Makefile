include ../../Makefile.inc

ZX02 = ~/research/6502_compression/zx02.git/build/zx02
PNG_TO_HGR = ../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../linker_scripts
DOS33 = ../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../empty_disk/empty.dsk
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	sb.dsk

####

sb.dsk:	HELLO SB
	cp $(EMPTY_DISK) sb.dsk
	$(DOS33) -y sb.dsk SAVE A HELLO
	$(DOS33) -y sb.dsk BSAVE -a 0x0c00 SB

####

SB:	sb.o
	ld65 -o SB sb.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

sb.o:	sb.s zx02_optim.s \
		zp.inc hardware.inc
	ca65 -o sb.o sb.s -l sb.lst

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:	
	rm -f *.lst *.o SB *~
