include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk

all:	xdraw_wave_16.dsk

xdraw_wave_16.dsk:	HELLO XDRAW_WAVE
	cp $(EMPTYDISK) xdraw_wave_16.dsk
	$(DOS33) -y xdraw_wave_16.dsk SAVE A HELLO
	$(DOS33) -y xdraw_wave_16.dsk BSAVE -a 0xE7 XDRAW_WAVE

###

submit:	xdraw_wave16.zip

xdraw_wave16.zip:	XDRAW_WAVE xdraw_wave.s file_id.diz xdraw_wave_16.dsk
	mkdir -p lovebyte2022_xdraw_wave_16
	cp XDRAW_WAVE ./lovebyte2022_xdraw_wave_16
	cp xdraw_wave.s ./lovebyte2022_xdraw_wave_16
	cp file_id.diz ./lovebyte2022_xdraw_wave_16
	cp xdraw_wave_16.dsk ./lovebyte2022_xdraw_wave_16
	cp xdraw_wave_720p.mp4 ./lovebyte2022_xdraw_wave_16
	zip -r xdraw_wave16.zip lovebyte2022_xdraw_wave_16

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

XDRAW_WAVE:	xdraw_wave.o
	ld65 -o XDRAW_WAVE xdraw_wave.o -C ./apple2_e7_zp.inc

xdraw_wave.o:	xdraw_wave.s
	ca65 -o xdraw_wave.o xdraw_wave.s -l xdraw_wave.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO XDRAW_WAVE *.zip
