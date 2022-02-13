include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk
HGR2PNG = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	cometsong.dsk

####

submit:	cometsong256.zip

cometsong256.zip:	COMETSONG cometsong.s file_id.diz cometsong.dsk
	mkdir -p lovebyte2022_cometsong_256
	cp COMETSONG ./lovebyte2022_cometsong_256
	cp *.s ./lovebyte2022_cometsong_256
	cp file_id.diz ./lovebyte2022_cometsong_256
	cp cometsong.dsk ./lovebyte2022_cometsong_256
	cp cometsong_720p.mp4 ./lovebyte2022_cometsong_256
	zip -r cometsong256.zip lovebyte2022_cometsong_256

####

cometsong.dsk:	HELLO COMETSONG VIZ
	cp $(EMPTY_DISK)/empty.dsk ./cometsong.dsk
	$(DOS33) -y cometsong.dsk SAVE A HELLO
	$(DOS33) -y cometsong.dsk -t BIN -a 0x7E BSAVE COMETSONG
#	$(DOS33) -y cometsong.dsk -t BIN -a 0xc00 BSAVE VIZ

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

mA2E_2.s:	mA2E_2.txt text_to_tiny
	./text_to_tiny mA2E_2.txt > mA2E_2.s


####

COMETSONG:	cometsong.o
	ld65 -o COMETSONG cometsong.o -C ./apple2_7e_zp.inc

cometsong.o:	cometsong.s \
	zp.inc hardware.inc \
	mA2E_2.s visual.s \
	mockingboard_init.s play_frame.s \
	ay3_write_regs.s
	ca65 -o cometsong.o cometsong.s -l cometsong.lst

####

VIZ:	viz.o
	ld65 -o VIZ viz.o -C $(LINKER_SCRIPTS)/apple2_c00.inc

viz.o:	viz.s \
	zp.inc hardware.inc
	ca65 -o viz.o viz.s -l viz.lst


####

text_to_tiny:	text_to_tiny.o
	$(CC) -o text_to_tiny text_to_tiny.o -lm

text_to_tiny.o:	text_to_tiny.c
	$(CC) $(CFLAGS) -c text_to_tiny.c

####

clean:
	rm -f *~ *.o *.lst COMETSONG VIZ HELLO text_to_tiny mA2E_2.s
