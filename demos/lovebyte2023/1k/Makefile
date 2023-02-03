include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	blue_flame.dsk

###

blue_flame.dsk:	HELLO BLUE_FLAME BF
	cp $(EMPTYDISK) blue_flame.dsk
	$(DOS33) -y blue_flame.dsk SAVE A HELLO
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x8000 BLUE_FLAME
	$(DOS33) -y blue_flame.dsk BSAVE -a 0x6000 BF

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


###

submit:	blue_flame.zip

blue_flame.zip:	BLUE_FLAME blue_flame.dsk
	mkdir -p lovebyte2023_blue_flame
	mkdir -p lovebyte2023_blue_flame/src
	cp BLUE_FLAME ./lovebyte2023_blue_flame
	cp *.s ./lovebyte2023_blue_flame/src
	cp *.inc ./lovebyte2023_blue_flame/src
	cp file_id.diz ./lovebyte2023_blue_flame
	cp blue_flame.dsk ./lovebyte2023_blue_flame
	cp blue_flame.mkv ./lovebyte2023_blue_flame
	cp a2_desire_screen.png ./lovebyte2023_blue_flame
	zip -r blue_flame.zip lovebyte2023_blue_flame

####

BLUE_FLAME:	blue_flame.o
	ld65 -o BLUE_FLAME blue_flame.o -C $(LINKER_SCRIPTS)/apple2_8000.inc

blue_flame.o:	blue_flame.s \
	letters.s flame.s sier.s zp.inc \
	ay3_write_regs.s interrupt_handler.s play_frame.s \
	SmallLove2.s mockingboard_constants.s mockingboard_init.s \
	tracker_init.s static_column.s
	ca65 -o blue_flame.o blue_flame.s -l blue_flame.lst

####

BLUE_FLAME.ZX02:	BLUE_FLAME
	$(ZX02) -f BLUE_FLAME BLUE_FLAME.ZX02

BF:	bf.o
	ld65 -o BF bf.o -C $(LINKER_SCRIPTS)/apple2_6000.inc

bf.o:	bf.s zx02_small.s zx02_optim.s BLUE_FLAME.ZX02
	ca65 -o bf.o bf.s -l bf.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO BLUE_FLAME BF *.ZX02 *.zip make_points

