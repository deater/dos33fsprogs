include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	tick_tock.dsk

tick_tock.dsk:	HELLO TICK_TOCK
	cp $(EMPTYDISK) tick_tock.dsk
	$(DOS33) -y tick_tock.dsk SAVE A HELLO
	$(DOS33) -y tick_tock.dsk BSAVE -a 0xe7 TICK_TOCK

###

submit:	tick_tock.zip

tick_tock.zip:	TICK_TOCK tick_tock.s file_id.diz tick_tock.dsk
	mkdir -p lovebyte2023_tick_tock
	cp TICK_TOCK ./lovebyte2023_tick_tock
	cp tick_tock.s ./lovebyte2023_tick_tock
	cp file_id.diz ./lovebyte2023_tick_tock
	cp tick_tock.dsk ./lovebyte2023_tick_tock
	cp monitor.txt ./lovebyte2023_tick_tock
	cp tick_tock_screen.png ./lovebyte2023_tick_tock
	cp tick_tock_720p.mp4 ./lovebyte2023_tick_tock
	zip -r tick_tock.zip lovebyte2023_tick_tock

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TICK_TOCK:	tick_tock.o
	ld65 -o TICK_TOCK tick_tock.o -C $(LINKERSCRIPTS)/apple2_e7_zp.inc

tick_tock.o:	tick_tock.s
	ca65 -o tick_tock.o tick_tock.s -l tick_tock.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TICK_TOCK *.zip
