include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk/empty.dsk

all:	triangles.dsk

triangles.dsk:	HELLO TINY_TRIANGLES XOR MOD9 MOD9_64 WRITING MOVE_RIGHT
	cp $(EMPTY_DISK) triangles.dsk
	$(DOS33) -y triangles.dsk SAVE A HELLO
	$(DOS33) -y triangles.dsk BSAVE -a 0x070 TINY_TRIANGLES
	$(DOS33) -y triangles.dsk BSAVE -a 0x300 XOR
	$(DOS33) -y triangles.dsk BSAVE -a 0x300 MOD9
	$(DOS33) -y triangles.dsk BSAVE -a 0x300 MOD9_64
	$(DOS33) -y triangles.dsk BSAVE -a 0x300 WRITING
	$(DOS33) -y triangles.dsk BSAVE -a 0x300 MOVE_RIGHT

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TINY_TRIANGLES:	tiny_triangles.o
	ld65 -o TINY_TRIANGLES tiny_triangles.o -C $(LINKER_SCRIPTS)/apple2_70_zp.inc

tiny_triangles.o:	tiny_triangles.s
	ca65 -o tiny_triangles.o tiny_triangles.s -l tiny_triangles.lst

###

XOR:	xor.o
	ld65 -o XOR xor.o -C $(LINKER_SCRIPTS)/apple2_300.inc

xor.o:	xor.s
	ca65 -o xor.o xor.s -l xor.lst

###

MOD9:	mod9.o
	ld65 -o MOD9 mod9.o -C $(LINKER_SCRIPTS)/apple2_300.inc

mod9.o:	mod9.s
	ca65 -o mod9.o mod9.s -l mod9.lst

###

MOD9_64:	mod9_64.o
	ld65 -o MOD9_64 mod9_64.o -C $(LINKER_SCRIPTS)/apple2_300.inc

mod9_64.o:	mod9_64.s
	ca65 -o mod9_64.o mod9_64.s -l mod9_64.lst


###

WRITING:	writing.o
	ld65 -o WRITING writing.o -C $(LINKER_SCRIPTS)/apple2_300.inc

writing.o:	writing.s
	ca65 -o writing.o writing.s -l writing.lst

###

MOVE_RIGHT:	move_right.o
	ld65 -o MOVE_RIGHT move_right.o -C $(LINKER_SCRIPTS)/apple2_300.inc

move_right.o:	move_right.s
	ca65 -o move_right.o move_right.s -l move_right.lst



###

clean:	
	rm -f *~ *.o *.lst HELLO TINY_TRIANGLES XOR MOD9 MOD9_64 WRITING \
			MOVE_RIGHT
