include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	dsr_wires.dsk

dsr_wires.dsk:	HELLO DSR_WIRES
	cp $(EMPTYDISK) dsr_wires.dsk
	$(DOS33) -y dsr_wires.dsk SAVE A HELLO
	$(DOS33) -y dsr_wires.dsk BSAVE -a 0xc00 DSR_WIRES

###

submit:	dsr_wires.zip

dsr_wires.zip:	DSR_WIRES dsr_wires file_id.diz dsr_wires.dsk
	mkdir -p lovebyte2024_wires
	cp DSR_WIRES ./lovebyte2024_wires
	cp dsr_wires ./lovebyte2024_wires
	cp file_id.diz ./lovebyte2024_wires
	cp dsr_wires.dsk ./lovebyte2024_wires
	cp monitor.txt ./lovebyte2024_wires
	cp wires_screen.png ./lovebyte2024_wires
	cp wires_720p.mp4 ./lovebyte2024_wires
	zip -r dsr_wires.zip lovebyte2024_wires

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DSR_WIRES:	dsr_wires.o
	ld65 -o DSR_WIRES dsr_wires.o -C $(LINKERSCRIPTS)/apple2_c00.inc

dsr_wires.o:	dsr_wires.s
	ca65 -o dsr_wires.o dsr_wires.s -l dsr_wires.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO DSR_WIRES *.zip
