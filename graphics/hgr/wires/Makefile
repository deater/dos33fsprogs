include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	wires.dsk

wires.dsk:	HELLO WIRES WIRES_BOT CYCLE STAGGERED BLUEORANGE BLUEORANGEZ \
		STATIC STATIC_COLUMN
	cp $(EMPTY_DISK)/empty.dsk wires.dsk
	$(DOS33) -y wires.dsk SAVE A HELLO
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 WIRES
	$(DOS33) -y wires.dsk BSAVE -a 0x039a WIRES_BOT
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 CYCLE
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 STAGGERED
	$(DOS33) -y wires.dsk BSAVE -a 0x0373 BLUEORANGE
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 BLUEORANGEZ
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 STATIC
	$(DOS33) -y wires.dsk BSAVE -a 0x0C00 STATIC_COLUMN

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

WIRES:	wires.o
	ld65 -o WIRES wires.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

wires.o:	wires.s
	ca65 -o wires.o wires.s -l wires.lst

####

WIRES_BOT:	wires_bot.o
	ld65 -o WIRES_BOT wires_bot.o -C $(LINKER_SCRIPTS)/apple2_39a.inc

wires_bot.o:	wires_bot.s
	ca65 -o wires_bot.o wires_bot.s -l wires_bot.lst


####

STAGGERED:	staggered.o
	ld65 -o STAGGERED staggered.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

staggered.o:	staggered.s
	ca65 -o staggered.o staggered.s -l staggered.lst

####

STATIC:	static.o
	ld65 -o STATIC static.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

static.o:	static.s
	ca65 -o static.o static.s -l static.lst

####

STATIC_COLUMN:	static_column.o
	ld65 -o STATIC_COLUMN static_column.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

static_column.o:	static_column.s
	ca65 -o static_column.o static_column.s -l static_column.lst


####

CYCLE:	cycle.o
	ld65 -o CYCLE cycle.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

cycle.o:	cycle.s
	ca65 -o cycle.o cycle.s -l cycle.lst

####

BLUEORANGE:	blueorange.o
	ld65 -o BLUEORANGE blueorange.o -C $(LINKER_SCRIPTS)/apple2_373.inc

blueorange.o:	blueorange.s
	ca65 -o blueorange.o blueorange.s -l blueorange.lst

####

BLUEORANGEZ:	blueorange.o
	ld65 -o BLUEORANGEZ blueorange.o -C $(LINKER_SCRIPTS)/apple2_c00.inc


######

clean:	
	rm -f *~ *.o *.lst WIRES CYCLE STAGGERED STATIC STATIC_COLUMN
