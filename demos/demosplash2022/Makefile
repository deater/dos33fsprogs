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


#submit:	apple_desire512.zip

#apple_desire512.zip:	APPLE_DESIRE apple_desire.s file_id.diz apple_desire_512.dsk
#	mkdir -p lovebyte2021_apple_desire_512
#	cp APPLE_DESIRE ./lovebyte2021_apple_desire_512
#	cp *.s ./lovebyte2021_apple_desire_512
#	cp file_id.diz ./lovebyte2021_apple_desire_512
#	cp apple_desire_512.dsk ./lovebyte2021_apple_desire_512
#	cp apple_desire_512.woz ./lovebyte2021_apple_desire_512
#	cp apple_desire_720p.mp4 ./lovebyte2021_apple_desire_512
#	cp desire2.png ./lovebyte2021_apple_desire_512
#	zip -r apple_desire512.zip lovebyte2021_apple_desire_512

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

