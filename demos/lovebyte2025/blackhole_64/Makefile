include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	blackhole_64.dsk

blackhole_64.dsk:	HELLO BLACKHOLE_64
	cp $(EMPTYDISK) blackhole_64.dsk
	$(DOS33) -y blackhole_64.dsk SAVE A HELLO
	$(DOS33) -y blackhole_64.dsk BSAVE -a 0xe7 BLACKHOLE_64

###

submit:	blackhole_64.zip

blackhole_64.zip:	BLACKHOLE_64 blackhole_64.s file_id.diz blackhole_64.dsk
	mkdir -p lovebyte2025_blackhole_64
	cp BLACKHOLE_64 ./lovebyte2025_blackhole_64
	cp blackhole_64.s ./lovebyte2025_blackhole_64
	cp file_id.diz ./lovebyte2025_blackhole_64
	cp blackhole_64.dsk ./lovebyte2025_blackhole_64
	cp monitor.txt ./lovebyte2025_blackhole_64
	cp blackhole_64_screen.png ./lovebyte2025_blackhole_64
	cp blackhole_64_720p.mp4 ./lovebyte2025_blackhole_64
	zip -r blackhole_64.zip lovebyte2025_blackhole_64

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

BLACKHOLE_64:	blackhole_64.o
	ld65 -o BLACKHOLE_64 blackhole_64.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

blackhole_64.o:	blackhole_64.s
	ca65 -o blackhole_64.o blackhole_64.s -l blackhole_64.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO BLACKHOLE_64 *.zip
