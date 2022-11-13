include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
PICTUREDSK = ~/research/picturedsk.git/picturedsk
LINKER_SCRIPTS = ../../linker_scripts/

all:	hgr_escape.dsk

###

hgr_escape.dsk:	HELLO ESCAPE
	cp $(EMPTYDISK) hgr_escape.dsk
	$(DOS33) -y hgr_escape.dsk SAVE A HELLO
	$(DOS33) -y hgr_escape.dsk BSAVE -a 0xc00 ESCAPE

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO


#submit:	escape512.zip

#escape512.zip:	ESCAPE escape.s file_id.diz escape_512.dsk
#	mkdir -p lovebyte2021_escape_512
#	cp ESCAPE ./lovebyte2021_escape_512
#	cp *.s ./lovebyte2021_escape_512
#	cp file_id.diz ./lovebyte2021_escape_512
#	cp escape_512.dsk ./lovebyte2021_escape_512
#	cp escape_512.woz ./lovebyte2021_escape_512
#	cp escape_720p.mp4 ./lovebyte2021_escape_512
#	cp desire2.png ./lovebyte2021_escape_512
#	zip -r escape512.zip lovebyte2021_escape_512

####

ESCAPE:	escape.o
	ld65 -o ESCAPE escape.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

escape.o:	escape.s \
	logo_intro.s zp.inc \
	ay3_write_regs.s escape.s interrupt_handler.s \
	play_frame.s draw_letter.s freq.s freq_h.s bamps.s \
	apple_logo.s \
	mA2E_4.s mockingboard_constants.s mockingboard_init.s tracker_init.s
	ca65 -o escape.o escape.s -l escape.lst

####

make_points:	make_points.o
	$(CC) -o make_points make_points.o

make_points.o:	make_points.c
	$(CC) $(CFLAGS) -c make_points.c

####

clean:	
	rm -f *~ *.o *.lst ESCAPE *.zip make_points

