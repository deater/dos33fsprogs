include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../linker_scripts/

all:	apple_desire.dsk

###

apple_desire.dsk:	HELLO APPLE_DESIRE
	cp $(EMPTYDISK) apple_desire.dsk
	$(DOS33) -y apple_desire.dsk SAVE A HELLO
	$(DOS33) -y apple_desire.dsk BSAVE -a 0xc00 APPLE_DESIRE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


submit:	apple2_desire.zip

apple2_desire.zip:	APPLE_DESIRE apple_desire.dsk
	mkdir -p demosplash2022_apple2_desire
	mkdir -p demosplash2022_apple2_desire/src
	cp APPLE_DESIRE ./demosplash2022_apple2_desire
	cp *.s ./demosplash2022_apple2_desire/src
	cp *.inc ./demosplash2022_apple2_desire/src
	cp file_id.diz ./demosplash2022_apple2_desire
	cp apple_desire.dsk ./demosplash2022_apple2_desire
	cp apple2_desire.mkv ./demosplash2022_apple2_desire
	cp a2_desire_screen.png ./demosplash2022_apple2_desire
	zip -r apple2_desire.zip demosplash2022_apple2_desire

####

APPLE_DESIRE:	apple_desire.o
	ld65 -o APPLE_DESIRE apple_desire.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

apple_desire.o:	apple_desire.s \
	logo_intro.s zp.inc \
	ay3_write_regs.s apple_desire.s interrupt_handler.s \
	play_frame.s draw_letter.s freq.s freq_h.s bamps.s \
	apple_logo.s \
	mA2E_4.s mockingboard_constants.s mockingboard_init.s tracker_init.s
	ca65 -o apple_desire.o apple_desire.s -l apple_desire.lst

####

make_points:	make_points.o
	$(CC) -o make_points make_points.o

make_points.o:	make_points.c
	$(CC) $(CFLAGS) -c make_points.c

####

clean:	
	rm -f *~ *.o *.lst APPLE_DESIRE *.zip make_points

