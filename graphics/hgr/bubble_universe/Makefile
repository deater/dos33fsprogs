include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	bubble.dsk make_table

bubble.dsk:	HELLO BUBBLE.BAS BUBBLE BUBBLE_C64 \
		BUBBLE_ORIG BUBBLE_ROLLED DIAMOND FAST_DOTS
	cp $(EMPTY_DISK)/empty.dsk bubble.dsk
	$(DOS33) -y bubble.dsk SAVE A HELLO
	$(DOS33) -y bubble.dsk SAVE A BUBBLE.BAS
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_ORIG
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_ROLLED
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 DIAMOND
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 FAST_DOTS
	$(DOS33) -y bubble.dsk BSAVE -a 0x0C00 BUBBLE_C64

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BUBBLE:	bubble.o
	ld65 -o BUBBLE bubble.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble.o:	bubble.s hgr_clear_part.s sin_unrolled.s
	ca65 -o bubble.o bubble.s -l bubble.lst

###

BUBBLE_C64:	bubble_c64.o
	ld65 -o BUBBLE_C64 bubble_c64.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_c64.o:	bubble_c64.s hgr_clear_part.s sin_unrolled.s
	ca65 -o bubble_c64.o bubble_c64.s -l bubble_c64.lst


###

BUBBLE_ORIG:	bubble_orig.o
	ld65 -o BUBBLE_ORIG bubble_orig.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_orig.o:	bubble_orig.s
	ca65 -o bubble_orig.o bubble_orig.s -l bubble_orig.lst

###

BUBBLE_ROLLED:	bubble_rolled.o
	ld65 -o BUBBLE_ROLLED bubble_rolled.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

bubble_rolled.o:	bubble_rolled.s
	ca65 -o bubble_rolled.o bubble_rolled.s -l bubble_rolled.lst



###

DIAMOND:	diamond.o
	ld65 -o DIAMOND diamond.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

diamond.o:	diamond.s
	ca65 -o diamond.o diamond.s -l diamond.lst

###

FAST_DOTS:	fast_dots.o
	ld65 -o FAST_DOTS fast_dots.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

fast_dots.o:	fast_dots.s
	ca65 -o fast_dots.o fast_dots.s -l fast_dots.lst



###

BUBBLE.BAS:	bubble.bas
	$(TOKENIZE) < bubble.bas > BUBBLE.BAS


###

make_table:	make_table.o
	$(CC) -o make_table make_table.o -lm

make_table.o:	make_table.c
	$(CC) $(CFLAGS) -c make_table.c

###

clean:	
	rm -f *~ *.o *.lst BUBBLE.BAS HELLO BUBBLE BUBBLE_C64 \
		DIAMOND BUBBLE_ORIG BUBBLE_ROLLED FAST_DOTS
