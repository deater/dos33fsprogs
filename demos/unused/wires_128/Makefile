include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	wires.dsk

wires.dsk:	HELLO WIRES
	cp $(EMPTYDISK) wires.dsk
	$(DOS33) -y wires.dsk SAVE A HELLO
	$(DOS33) -y wires.dsk BSAVE -a 0xc00 WIRES

###

submit:	wires.zip

wires.zip:	WIRES wires.s file_id.diz wires.dsk
	mkdir -p lovebyte2023_wires
	cp WIRES ./lovebyte2023_wires
	cp wires.s ./lovebyte2023_wires
	cp file_id.diz ./lovebyte2023_wires
	cp wires.dsk ./lovebyte2023_wires
	cp monitor.txt ./lovebyte2023_wires
	cp wires_screen.png ./lovebyte2023_wires
	cp wires_720p.mp4 ./lovebyte2023_wires
	zip -r wires.zip lovebyte2023_wires

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

WIRES:	wires.o
	ld65 -o WIRES wires.o -C $(LINKERSCRIPTS)/apple2_c00.inc

wires.o:	wires.s
	ca65 -o wires.o wires.s -l wires.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO WIRES *.zip
